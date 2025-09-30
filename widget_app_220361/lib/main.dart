import 'package:flutter/material.dart';
import 'package:widget_app_220361/theme/app_theme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).getTheme(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Widget App 220361')),//AppBar
        body: Center(
          child: FilledButton(onPressed:(){},child:Text('Click me')),
        ),
      ),
    );
  }
}
