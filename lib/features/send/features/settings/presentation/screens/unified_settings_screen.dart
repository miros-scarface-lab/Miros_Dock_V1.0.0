import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miros_share_and_web_dock/features/send/core/theme/app_theme.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/name_generator.dart';
import '../providers/settings_provider.dart';
import '../../domain/entities/settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:miros_share_and_web_dock/core/app_providers.dart';
import 'package:miros_share_and_web_dock/features/web_dock/server/auth_service.dart';
import 'package:miros_share_and_web_dock/features/web_dock/features/settings/shared_folders_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class UnifiedSettingsScreen extends ConsumerStatefulWidget {
  const UnifiedSettingsScreen({super.key});

  @override
  ConsumerState<UnifiedSettingsScreen> createState() =>
      _UnifiedSettingsScreenState();
}

class _UnifiedSettingsScreenState extends ConsumerState<UnifiedSettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _authEnabled = false;
  bool _uploadEnabled = false;
  bool _downloadEnabled = true;
  bool _deleteEnabled = false;
  bool _renameEnabled = false;
  bool _isWebDockLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWebDockConfig();
  }

  Future<void> _loadWebDockConfig() async {
    final config = await ref.read(databaseProvider).getConfig();
    if (mounted) {
      setState(() {
        _usernameController.text = config.adminUsername;
        _authEnabled = config.authenticationEnabled;
        _uploadEnabled = config.uploadEnabled;
        _downloadEnabled = config.downloadEnabled;
        _deleteEnabled = config.deleteEnabled;
        _renameEnabled = config.renameEnabled;
        _isWebDockLoading = false;
      });
    }
  }

  Future<void> _saveWebDockConfig() async {
    final db = ref.read(databaseProvider);
    final config = await db.getConfig();

    config.adminUsername = _usernameController.text;
    config.authenticationEnabled = _authEnabled;
    config.uploadEnabled = _uploadEnabled;
    config.downloadEnabled = _downloadEnabled;
    config.deleteEnabled = _deleteEnabled;
    config.renameEnabled = _renameEnabled;

    if (_passwordController.text.isNotEmpty) {
      config.adminPasswordHash = AuthService(db).hashPassword(_passwordController.text);
    }

    await db.saveConfig(config);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuration Synchronized')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL CENTER', style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.w900, letterSpacing: 4)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline, color: CyberColors.successStatic),
            onPressed: _saveWebDockConfig,
            tooltip: 'Sync Changes',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CyberColors.backgroundStatic,
              CyberColors.backgroundStatic.withValues(alpha: 0.8),
              CyberColors.surfaceStatic.withValues(alpha: 0.5),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            _buildHeader('NEURAL IDENTITY'),
            _buildGlassCard(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: const Text('Node Name', style: TextStyle(color: CyberColors.textSecondaryStatic, fontSize: 12)),
                subtitle: Text(
                  settings.deviceName.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    color: colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.refresh, color: colorScheme.primary),
                  onPressed: () {
                    final newName = CyberNameGenerator.generate();
                    notifier.setDeviceName(newName);
                  },
                ),
                onTap: () => _showEditNameDialog(context, ref, settings.deviceName),
              ),
            ),
            const SizedBox(height: 32),
            _buildHeader('VISUAL INTERFACE'),
            _buildGlassCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    const Text('Theme Preset', style: TextStyle(color: CyberColors.textSecondaryStatic, fontSize: 12)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildThemeOption(ThemePreset.neonBlue, const Color(0xFF00F3FF), settings.themePreset),
                        _buildThemeOption(ThemePreset.neonPink, const Color(0xFFFF00E5), settings.themePreset),
                        _buildThemeOption(ThemePreset.acidGreen, const Color(0xFF39FF14), settings.themePreset),
                        _buildThemeOption(ThemePreset.solarOrange, const Color(0xFFFFAC1C), settings.themePreset),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildHeader('DATA STREAM PROTOCOLS'),
            _buildGlassCard(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Download Matrix'),
                    subtitle: Text(settings.downloadPath, style: const TextStyle(fontSize: 11)),
                    trailing: Icon(Icons.folder_open, color: colorScheme.secondary),
                    onTap: () async {
                      String? selectedDirectory = await FilePicker.getDirectoryPath();
                      if (selectedDirectory != null) {
                        notifier.updateSettings(settings.copyWith(downloadPath: selectedDirectory));
                      }
                    },
                  ),
                  const Divider(color: CyberColors.glassStatic, height: 1),
                  SwitchListTile(
                    title: const Text('Auto-Authorize'),
                    subtitle: const Text('Instantly accept data inbound', style: TextStyle(fontSize: 11)),
                    value: settings.autoAccept,
                    activeThumbColor: colorScheme.primary,
                    onChanged: (value) => notifier.updateSettings(settings.copyWith(autoAccept: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildHeader('WEB DOCK NODE'),
            if (_isWebDockLoading)
              const Center(child: CircularProgressIndicator())
            else
              _buildGlassCard(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Virtual Directories'),
                      subtitle: const Text('Manage web-accessible data', style: TextStyle(fontSize: 11)),
                      trailing: Icon(Icons.lan, color: colorScheme.primary, size: 20),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SharedFoldersScreen())),
                    ),
                    const Divider(color: CyberColors.glassStatic, height: 1),
                    SwitchListTile(
                      title: const Text('Security Lock'),
                      subtitle: const Text('Require admin credentials', style: TextStyle(fontSize: 11)),
                      value: _authEnabled,
                      activeThumbColor: colorScheme.primary,
                      onChanged: (val) => setState(() => _authEnabled = val),
                    ),
                    if (_authEnabled) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(labelText: 'Admin ID', isDense: true),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(labelText: 'Access Key', hintText: 'New password...', isDense: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 32),
            _buildHeader('SYSTEM ARCHITECT'),
            _buildGlassCard(
              child: InkWell(
                onTap: () => _showAboutDialog(context),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.psychology, color: colorScheme.primary, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('MIR AK SAJID', style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('TAP TO REVEAL SYSTEM INFO', style: TextStyle(color: colorScheme.primary, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ],
                        ),
                      ),
                      const Icon(Icons.info_outline, color: CyberColors.textSecondaryStatic, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: Text(
                'MIROS v1.0.0 • CYBER RELEASE',
                style: GoogleFonts.jetBrainsMono(color: CyberColors.textSecondaryStatic.withValues(alpha: 0.5), fontSize: 9, letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(ThemePreset preset, Color color, ThemePreset current) {
    final bool isSelected = preset == current;
    return GestureDetector(
      onTap: () {
        ref.read(settingsProvider.notifier).updateSettings(
          ref.read(settingsProvider).copyWith(themePreset: preset),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: isSelected ? const Icon(Icons.check, color: Colors.black, size: 18) : null,
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.jetBrainsMono(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: CyberColors.surfaceStatic.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CyberColors.glassStatic),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }

  void _showEditNameDialog(BuildContext context, WidgetRef ref, String currentName) {
    final controller = TextEditingController(text: currentName);
    final colorScheme = Theme.of(context).colorScheme;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CyberColors.surfaceStatic,
        title: Text('RE-IDENTITY NODE', style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, fontSize: 16)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: colorScheme.primary),
          decoration: const InputDecoration(hintText: 'Enter new identification...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ABORT')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(settingsProvider.notifier).setDeviceName(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('CONFIRM'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final secondary = colorScheme.secondary;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: CyberColors.surfaceStatic,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: primary.withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: 5,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary, secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.cloud_queue, size: 40, color: CyberColors.backgroundStatic),
              ),
              const SizedBox(height: 24),
              Text(
                'MIROS DOCK',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: primary,
                  letterSpacing: 4,
                ),
              ),
              const Text(
                'v1.0.0 CYBER RELEASE',
                style: TextStyle(color: CyberColors.textSecondaryStatic, fontSize: 10, letterSpacing: 2),
              ),
              const SizedBox(height: 24),
              const Divider(color: CyberColors.glassStatic),
              const SizedBox(height: 16),
              Text(
                'DEVELOPED BY',
                style: TextStyle(color: secondary, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
              const SizedBox(height: 8),
              Text(
                'MIR AK SAJID',
                style: GoogleFonts.jetBrainsMono(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'CSE STUDENT • PRSTU',
                style: TextStyle(color: CyberColors.textSecondaryStatic, fontSize: 11),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CyberColors.backgroundStatic.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'A high-performance neural link for cross-platform data synchronization and web docking.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CyberColors.textSecondaryStatic, fontSize: 11, fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => launchUrl(Uri.parse('mailto:miraksajid369@gmail.com')),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: primary)),
                      child: const Text('CONTACT'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CLOSE'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
