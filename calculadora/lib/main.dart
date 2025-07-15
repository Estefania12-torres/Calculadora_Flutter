import 'package:flutter/material.dart';
import 'package:calculadora/calculator.dart';
import 'package:flutter/services.dart';
import 'package:calculadora/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Small delay to ensure complete initialization
  await Future.delayed(const Duration(milliseconds: 100));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.darkWine,
          secondary: AppColors.pastelPink,
          background: AppColors.lightPink,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: AppColors.darkWine,
          onSurface: AppColors.darkWine,
        ),
        scaffoldBackgroundColor: AppColors.lightPink,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkWine,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.pastelPink,
            foregroundColor: AppColors.darkWine,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkWine),
          bodyMedium: TextStyle(color: AppColors.darkWine),
        ),
      ),
      home: const CalculatorPage(),
    );
  }
}
