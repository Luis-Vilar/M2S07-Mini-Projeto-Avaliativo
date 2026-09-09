import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/main_app.dart';

void bootstrap() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(MainApp());
    },
    (error, stack) async {
      log('Error $error, Stack : $stack');
    },
  );
}
