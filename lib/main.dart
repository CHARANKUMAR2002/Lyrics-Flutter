import 'package:flutter/material.dart';
import 'lyrics.dart';

void main(List<String> args) {
  runApp(LA());
}

class LA extends StatelessWidget {
  const LA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, useMaterial3: true),
      home: Lyrics(),
    );
  }
}