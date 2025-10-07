import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_app_220361/presentation/providers/discover_provider.dart';
import 'package:widget_app_220361/presentation/screens/discover/discover_screens.dart';
import 'package:widget_app_220361/theme/app_theme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers:[ChangeNotifierProvider(create:(_) => DiscoverProvider()..loadNextPage())],
      child: MaterialApp(
        title: "toktik",
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).getTheme(),
      home:const DiscoverScreen(),
      )
    );
  }
}
