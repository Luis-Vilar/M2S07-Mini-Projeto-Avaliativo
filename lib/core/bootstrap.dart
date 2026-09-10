import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/core/injection.dart';
import 'package:todo_app/core/main_app.dart';

void bootstrap() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      initDependencyInjection();
      runApp(MainApp());
    },
    (error, stack) async {
      log('Error $error, Stack : $stack');
    },
  );
}
