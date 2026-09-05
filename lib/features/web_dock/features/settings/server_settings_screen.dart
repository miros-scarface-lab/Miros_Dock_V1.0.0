import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miros_share_and_web_dock/core/app_providers.dart';
import '../dashboard/dashboard_screen.dart';

class ServerSettingsScreen extends ConsumerStatefulWidget {
  const ServerSettingsScreen({super.key});

  @override
  ConsumerState<ServerSettingsScreen> createState() =>
      _ServerSettingsScreenState();
}

class _ServerSettingsScreenState extends ConsumerState<ServerSettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _authEnabled = false;
  bool _uploadEnabled = false;
  bool _downloadEnabled = true;
  bool _deleteEnabled = false;
  bool _renameEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final config = await ref.read(databaseProvider).getConfig();
    if (!mounted) return;
    setState(() {
      _usernameController.text = config.adminUsername;
      _authEnabled = config.authenticationEnabled;
      _uploadEnabled = config.uploadEnabled;
      _downloadEnabled = config.downloadEnabled;
      _deleteEnabled = config.deleteEnabled;
      _renameEnabled = config.renameEnabled;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Server Settings')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Security',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SwitchListTile(
                  title: const Text('Require Authentication'),
                  value: _authEnabled,
                  onChanged: (val) => setState(() => _authEnabled = val),
                ),
                if (_authEnabled) ...[
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Admin Username',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Leave blank to keep current',
                    ),
                    obscureText: true,
                  ),
                ],
                const Divider(height: 32),
                const Text(
                  'Permissions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SwitchListTile(
                  title: const Text('Allow Downloads'),
                  value: _downloadEnabled,
                  onChanged: (val) => setState(() => _downloadEnabled = val),
                ),
                SwitchListTile(
                  title: const Text('Allow Uploads'),
                  value: _uploadEnabled,
                  onChanged: (val) => setState(() => _uploadEnabled = val),
                ),
                SwitchListTile(
                  title: const Text('Allow Rename'),
                  value: _renameEnabled,
                  onChanged: (val) => setState(() => _renameEnabled = val),
                ),
                SwitchListTile(
                  title: const Text('Allow Deletion'),
                  value: _deleteEnabled,
                  onChanged: (val) => setState(() => _deleteEnabled = val),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    final db = ref.read(databaseProvider);
                    final auth = ref.read(authServiceProvider);
                    final config = await db.getConfig();

                    config.authenticationEnabled = _authEnabled;
                    config.adminUsername = _usernameController.text;
                    config.uploadEnabled = _uploadEnabled;
                    config.downloadEnabled = _downloadEnabled;
                    config.deleteEnabled = _deleteEnabled;
                    config.renameEnabled = _renameEnabled;

                    if (_passwordController.text.isNotEmpty) {
                      config.adminPasswordHash = auth.hashPassword(
                        _passwordController.text,
                      );
                    }

                    await db.saveConfig(config);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings saved')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('SAVE SETTINGS'),
                ),
              ],
            ),
    );
  }
}
