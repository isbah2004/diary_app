import 'package:diary_app/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      title: 'Diary',
      home: HomeScreen(),
    ),
  );
}
