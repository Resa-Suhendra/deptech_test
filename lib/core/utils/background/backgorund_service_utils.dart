import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:deptech_test/core/utils/notification/notification_utils.dart';
import 'package:deptech_test/core/view_model/notes_provider.dart';
import 'package:deptech_test/injector.dart';
import 'package:deptech_test/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final ReceivePort port = ReceivePort();
class BackgroundServiceUtils {

  static BackgroundServiceUtils? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
 
  BackgroundServiceUtils._internal() {
    _instance = this;
  }
 
  factory BackgroundServiceUtils() => _instance ?? BackgroundServiceUtils._internal();
 
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    String id ="1";
    debugPrint('Alarm fired!');

    setupLocator();
    final notificationUtils = locator<NotificationUtils>();

    notificationUtils.showNotification(
      flutterLocalNotificationsPlugin,
      "Hello Test ${id}",
      "${id} Your reminder!",
      id
    );
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    debugPrint('Updated data from the background isolate');
  }

}