import 'dart:io';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class ForegroundService {
  static void init() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'server_channel',
        channelName: 'Server Status',
        channelDescription: 'Shows the status of the media server.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> start(String url) async {
    if (!Platform.isAndroid) return;

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Media Server ONLINE',
        notificationText: url,
      );
    } else {
      await FlutterForegroundTask.startService(
        notificationTitle: 'Media Server ONLINE',
        notificationText: url,
        callback: startCallback,
      );
    }
  }

  static Future<void> stop() async {
    if (!Platform.isAndroid) return;
    await FlutterForegroundTask.stopService();
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(ServerTaskHandler());
}

class ServerTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter taskStarter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
  
  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp();
  }
}



