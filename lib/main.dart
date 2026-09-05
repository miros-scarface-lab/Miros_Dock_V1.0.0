import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

// App 1 Imports
import 'package:miros_share_and_web_dock/core/app_providers.dart';
import 'package:miros_share_and_web_dock/features/send/core/theme/app_theme.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/permission_manager.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:miros_share_and_web_dock/features/send/features/transfer/presentation/providers/transfer_provider.dart';

// App 2 Imports
import 'package:miros_share_and_web_dock/features/web_dock/data/database/database_service.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/presentation/providers/settings_provider.dart';
import 'package:miros_share_and_web_dock/features/web_dock/core/utils/foreground_service.dart';
import 'package:miros_share_and_web_dock/core/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Logging (App 2)
  _setupLogging();

  // Initialize Foreground Service (App 2)
  ForegroundService.init();

  // Initialize Hive (App 1)
  final settingsDataSource = SettingsLocalDataSource();
  await settingsDataSource.init();

  // Initialize Isar (App 2)
  final db = DatabaseService();
  await db.init();

  // Window Manager for Desktop (App 1)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1200, 800),
      center: true,
      title: 'Miros Share & Web Dock',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // Request critical permissions on startup for Android (App 1)
  if (Platform.isAndroid) {
    await PermissionManager.requestAllPermissions();
  }

  final container = ProviderContainer(
    overrides: [databaseProvider.overrideWithValue(db)],
  );

  // Pre-initialize transfer repository (App 1)
  container.read(transferRepositoryProvider);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MirosMergedApp(),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class MirosMergedApp extends ConsumerWidget {
  const MirosMergedApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'Miros Dock',
      theme: AppTheme.getTheme(settings.themePreset),
      debugShowCheckedModeBanner: false,
      home: const UniversalSplashScreen(),
    );
  }
}
