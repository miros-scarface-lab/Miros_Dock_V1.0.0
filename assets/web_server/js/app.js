let currentPath = '';
let selectedItem = null;
let currentItems = [];
let activeFilter = 'all';
let viewMode = localStorage.getItem('viewMode') || 'grid';

document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initEventListeners();
    loadContent('');
});

function initEventListeners() {
    // Top Bar Actions
    document.getElementById('menuBtn').addEventListener('click', toggleSidebar);
    document.getElementById('themeToggleBtn').addEventListener('click', toggleTheme);
    document.getElementById('viewToggleBtn').addEventListener('click', toggleViewMode);
    document.getElementById('logoutBtn').addEventListener('click', logout);
    document.getElementById('searchInput').addEventListener('input', handleSearch);

    // Sidebar / New Actions
    document.getElementById('newMenuBtn').addEventListener('click', (e) => {
        e.stopPropagation();
        document.getElementById('newDropdown').classList.toggle('hidden');
    });

    document.getElementById('uploadBtn').addEventListener('click', () => {
        document.getElementById('fileInput').click();
        hideDropdowns();
    });

    document.getElementById('uploadFolderBtn').addEventListener('click', () => {
        document.getElementById('folderInput').click();
        hideDropdowns();
    });

    document.getElementById('newFolderBtn').addEventListener('click', () => {
        handleNewFolder();
        hideDropdowns();
    });

    // File Inputs
    document.getElementById('fileInput').addEventListener('change', (e) => handleUpload(e, false));
    document.getElementById('folderInput').addEventListener('change', (e) => handleUpload(e, true));

    // Modal Actions
    document.getElementById('closeModal').addEventListener('click', closeActionModal);
    document.getElementById('actionOpen').addEventListener('click', () => {
        if (selectedItem) { handleFileClick(selectedItem); closeActionModal(); }
    });
    document.getElementById('actionDownload').addEventListener('click', () => {
        if (selectedItem) { downloadFile(selectedItem); closeActionModal(); }
    });
    document.getElementById('actionRename').addEventListener('click', () => {
        if (selectedItem) { handleRename(selectedItem.name); closeActionModal(); }
    });
    document.getElementById('actionDelete').addEventListener('click', () => {
        if (selectedItem) { handleDelete(selectedItem.name); closeActionModal(); }
    });

    // Player Actions
    document.getElementById('closePlayer').addEventListener('click', closePlayer);

    // Global Clicks
    document.addEventListener('click', (e) => {
        hideDropdowns();

        // Close sidebar if clicking outside of it on mobile
        const sidebar = document.getElementById('sidebar');
        const menuBtn = document.getElementById('menuBtn');
        if (window.innerWidth <= 768 &&
            sidebar.classList.contains('active') &&
            !sidebar.contains(e.target) &&
            !menuBtn.contains(e.target)) {
            toggleSidebar();
        }
    });
}

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('active');
}

function hideDropdowns() {
    document.getElementById('newDropdown').classList.add('hidden');
}

function initTheme() {
    const savedTheme = localStorage.getItem('theme') || 'light';
    setTheme(savedTheme);
}

function toggleTheme() {
    const isDark = document.body.classList.contains('dark-mode');
    setTheme(isDark ? 'light' : 'dark');
}

function setTheme(theme) {
    const icon = document.getElementById('themeIcon');
    if (theme === 'dark') {
        document.body.classList.add('dark-mode');
        document.body.classList.remove('light-mode');
        icon.textContent = 'light_mode';
    } else {
        document.body.classList.remove('dark-mode');
        document.body.classList.add('light-mode');
        icon.textContent = 'dark_mode';
    }
    localStorage.setItem('theme', theme);
}

function toggleViewMode() {
    viewMode = viewMode === 'grid' ? 'list' : 'grid';
    localStorage.setItem('viewMode', viewMode);
    renderItems(currentItems);
}

async function loadContent(path) {
    currentPath = path;
    updateBreadcrumb(path);

    // Ensure sidebar is closed on mobile after navigation/load
    const sidebar = document.getElementById('sidebar');
    if (sidebar) sidebar.classList.remove('active');

    const content = document.getElementById('content');
    content.innerHTML = '<div class="initial-loader"><div class="pulse-ring"></div><span>Fetching data...</span></div>';

    const token = localStorage.getItem('session_token');
    const headers = token ? { 'Authorization': `Bearer ${token}` } : {};

    try {
        const endpoint = path ? `/api/files/${path}` : '/api/folders';
        const response = await fetch(endpoint, { headers });

        if (response.status === 401) {
            window.location.href = '/login.html';
            return;
        }

        if (!response.ok) throw new Error('Failed to load items');
        const items = await response.json();

        currentItems = path ? items.map(item => ({
            ...item,
            virtualPath: item.virtualPath || (path ? `${path}/${item.name}` : item.name)
        })) : items.map(f => ({
            name: f.name, isDirectory: true, virtualPath: f.virtualPath, size: 0
        }));

        renderItems(currentItems);
    } catch (e) {
        content.innerHTML = `<div class="error-state"><span class="material-icons-round">error_outline</span><p>${e.message}</p></div>`;
    }
}

function renderItems(items) {
    const content = document.getElementById('content');
    content.className = viewMode === 'grid' ? 'items-grid' : 'items-grid list-mode';
    content.innerHTML = '';

    let filtered = activeFilter === 'all' ? items : items.filter(i => i.isDirectory || getFileType(i.name) === activeFilter);

    if (filtered.length === 0) {
        content.innerHTML = '<div class="empty-state"><span class="material-icons-round">folder_open</span><p>No items found here.</p></div>';
        return;
    }

    filtered.forEach(item => {
        const card = document.createElement('div');
        card.className = 'file-card';

        const type = item.isDirectory ? 'folder' : getFileType(item.name);
        const icon = item.isDirectory ? 'folder' : getFileIcon(item.name);

        card.innerHTML = `
            <span class="material-icons-round file-icon">${icon}</span>
            <div class="file-name">${item.name}</div>
            <div class="file-info">${item.isDirectory ? 'Folder' : formatBytes(item.size)}</div>
        `;

        card.onclick = () => {
            if (item.isDirectory) {
                loadContent(item.virtualPath);
                if (window.innerWidth <= 768) toggleSidebar();
            } else {
                showActionModal(item);
            }
        };

        content.appendChild(card);
    });
}

async function filterByType(type) {
    activeFilter = type;
    document.querySelectorAll('.nav-link').forEach(l => l.classList.toggle('active', l.dataset.type === type));
    if (window.innerWidth <= 768) toggleSidebar();

    if (type === 'all') {
        loadContent('');
        return;
    }

    const content = document.getElementById('content');
    content.innerHTML = '<div class="initial-loader"><div class="pulse-ring"></div><span>Searching for ' + type + 's...</span></div>';

    const token = localStorage.getItem('session_token');
    const headers = token ? { 'Authorization': `Bearer ${token}` } : {};

    try {
        const response = await fetch(`/api/search?type=${type}`, { headers });
        if (!response.ok) throw new Error('Search failed');
        const items = await response.json();

        currentItems = items;
        renderItems(currentItems);
    } catch (e) {
        content.innerHTML = `<div class="error-state"><span class="material-icons-round">error_outline</span><p>${e.message}</p></div>`;
    }
}

function handleSearch(e) {
    const query = e.target.value.toLowerCase();
    const filtered = currentItems.filter(i => i.name.toLowerCase().includes(query));
    renderItems(filtered);
}

function showActionModal(item) {
    selectedItem = item;
    const modal = document.getElementById('actionModal');
    document.getElementById('modalTitle').textContent = item.name;
    modal.classList.remove('hidden');

    const preview = document.getElementById('modalPreview');
    const type = getFileType(item.name);
    const fileUrl = getAuthenticatedUrl(item.virtualPath);

    if (type === 'image') {
        preview.innerHTML = `<img src="${fileUrl}" style="width:100%; height:150px; object-fit:cover; border-radius:12px;">`;
        preview.classList.remove('hidden');
    } else {
        preview.classList.add('hidden');
    }
}

function closeActionModal() {
    document.getElementById('actionModal').classList.add('hidden');
    selectedItem = null;
}

function handleFileClick(item) {
    const fileUrl = getAuthenticatedUrl(item.virtualPath);
    const type = getFileType(item.name);

    const overlay = document.getElementById('playerOverlay');
    overlay.classList.remove('hidden');

    document.getElementById('imageViewer').classList.add('hidden');
    document.getElementById('videoViewer').classList.add('hidden');
    document.getElementById('audioViewer').classList.add('hidden');

    if (type === 'image') {
        document.getElementById('imageViewer').classList.remove('hidden');
        document.getElementById('lightboxImage').src = fileUrl;
    } else if (type === 'video') {
        document.getElementById('videoViewer').classList.remove('hidden');
        const v = document.getElementById('videoPlayer'); v.src = fileUrl; v.play();
    } else if (type === 'audio') {
        document.getElementById('audioViewer').classList.remove('hidden');
        document.getElementById('audioTitle').textContent = item.name;
        const a = document.getElementById('audioPlayer'); a.src = fileUrl; a.play();
    } else {
        overlay.classList.add('hidden');
        window.open(fileUrl, '_blank');
    }
}

function closePlayer() {
    document.getElementById('playerOverlay').classList.add('hidden');
    document.getElementById('videoPlayer').pause();
    document.getElementById('audioPlayer').pause();
}

async function handleUpload(e, isFolder) {
    const files = e.target.files;
    if (files.length === 0) return;

    const prog = document.getElementById('uploadProgress');
    prog.classList.remove('hidden');

    const token = localStorage.getItem('session_token');

    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const formData = new FormData();
        formData.append('file', file);

        const headers = token ? { 'Authorization': `Bearer ${token}` } : {};
        if (isFolder && file.webkitRelativePath) headers['x-relative-path'] = file.webkitRelativePath;

        try {
            await fetch(`/api/upload/${currentPath}`, { method: 'POST', headers, body: formData });
        } catch (err) { console.error(err); }
    }

    prog.classList.add('hidden');
    loadContent(currentPath);
    e.target.value = '';
}

async function handleNewFolder() {
    if (!currentPath) {
        alert('Cannot create folders in the root directory. Please enter a shared folder first.');
        return;
    }
    const name = prompt('Folder Name:');
    if (!name) return;
    const token = localStorage.getItem('session_token');
    try {
        const response = await fetch(`/api/files/${currentPath}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json', ...(token ? { 'Authorization': `Bearer ${token}` } : {}) },
            body: JSON.stringify({ name })
        });
        if (response.ok) {
            loadContent(currentPath);
        } else {
            const error = await response.text();
            alert(`Error: ${error}`);
        }
    } catch (err) {
        alert('Failed to create folder.');
    }
}

async function handleRename(oldName) {
    const newName = prompt('New Name:', oldName);
    if (!newName || newName === oldName) return;
    const token = localStorage.getItem('session_token');

    await fetch(`/api/files/${selectedItem.virtualPath}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', ...(token ? { 'Authorization': `Bearer ${token}` } : {}) },
        body: JSON.stringify({ name: newName })
    });
    loadContent(currentPath);
}

async function handleDelete(name) {
    if (!confirm(`Delete "${name}"?`)) return;
    const token = localStorage.getItem('session_token');

    await fetch(`/api/files/${selectedItem.virtualPath}`, {
        method: 'DELETE',
        headers: token ? { 'Authorization': `Bearer ${token}` } : {}
    });
    loadContent(currentPath);
}

async function logout() {
    const token = localStorage.getItem('session_token');
    if (token) {
        try {
            await fetch('/api/auth/logout', {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}` }
            });
        } catch (err) {
            console.error(err);
        }
    }
    localStorage.removeItem('session_token');
    window.location.href = '/login.html';
}

function updateBreadcrumb(path) {
    const nav = document.getElementById('breadcrumb');
    nav.innerHTML = '<a href="#" onclick="loadContent(\'\'); return false;">Drive</a>';
    if (!path) return;
    const parts = path.split('/');
    let acc = '';
    parts.forEach(p => {
        acc += (acc ? '/' : '') + p;
        const currentAcc = acc;
        nav.innerHTML += `<span>/</span><a href="#" onclick="loadContent('${currentAcc}'); return false;">${p}</a>`;
    });
}

function getFileType(name) {
    const ext = name.split('.').pop().toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'svg'].includes(ext)) return 'image';
    if (['mp4', 'webm', 'ogg', 'mkv', 'avi', 'mov'].includes(ext)) return 'video';
    if (['mp3', 'wav', 'm4a', 'flac'].includes(ext)) return 'audio';
    return 'document';
}

function getFileIcon(name) {
    const type = getFileType(name);
    if (type === 'image') return 'image';
    if (type === 'video') return 'play_circle';
    if (type === 'audio') return 'audiotrack';
    return 'description';
}

function formatBytes(bytes, decimals = 1) {
    if (!bytes) return '0 B';
    const k = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(decimals)) + ' ' + sizes[i];
}

function downloadFile(item) {
    const fileUrl = getAuthenticatedUrl(item.virtualPath, true);
    const a = document.createElement('a'); a.href = fileUrl; a.download = item.name; a.click();
}

function getAuthenticatedUrl(virtualPath, isDownload = false) {
    const token = localStorage.getItem('session_token');
    let baseUrl = `/files/${virtualPath}`;
    const params = new URLSearchParams();
    if (token) params.append('token', token);
    if (isDownload) params.append('download', '1');

    const queryString = params.toString();
    return queryString ? `${baseUrl}?${queryString}` : baseUrl;
}
