import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'views/Home.dart';
import 'views/Info.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller de Flutter',
      home: const Home(),
      routes: <String, WidgetBuilder> {
        Info.route: (context) => Info(),
      },
    );
  }
}