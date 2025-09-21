import 'package:flutter/material.dart';
import 'package:main_thread/src/features/home/home.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main thread',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple,
          titleTextStyle: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
