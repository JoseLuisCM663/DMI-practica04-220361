import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_app_220361/presentation/providers/discover_provider.dart';
import 'package:widget_app_220361/presentation/screens/discover/discover_screens.dart';
import 'package:widget_app_220361/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:widget_app_220361/config/helpers/human_formants.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DiscoverProvider()..loadNextPage(),
        ),
      ],
      child: MaterialApp(
        title: 'TokTik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 1).getTheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}

// Splash Screen a PANTALLA COMPLETA
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // Restaurar la barra de estado
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DiscoverScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash/splash_image.png'),
            fit: BoxFit.cover, // Ocupa TODA la pantalla
          ),
        ),
      ),
    );
  }
}
