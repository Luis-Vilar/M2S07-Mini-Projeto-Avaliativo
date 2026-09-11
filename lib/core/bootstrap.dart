import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/core/injection.dart';
import 'package:todo_app/core/main_app.dart';
import 'package:todo_app/shared/data/db_helper.dart';

void bootstrap() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DbHelper.db;
      initDependencyInjection();
      runApp(MainApp());
    },
    (error, stack) async {
      log('Error $error, Stack : $stack');
    },
  );
}
