import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/provider/home_provider.dart';

import 'src/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    )
  );
}