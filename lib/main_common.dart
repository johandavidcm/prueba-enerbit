import 'package:flutter/services.dart';

import 'src/app.dart';
import 'package:flutter/material.dart';

import 'src/dependencies.dart';

void mainCommon() {
  setupDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const RickAndMortyApp());
}
