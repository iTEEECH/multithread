import 'package:compute/src/features/home/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compute',
      theme:  ThemeData(
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
