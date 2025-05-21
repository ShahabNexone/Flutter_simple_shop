import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/admin_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nexo Shop',
      theme: ThemeData(
        fontFamily: 'Vazir',
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Light gray background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blueGrey),
          titleTextStyle: TextStyle(
            fontFamily: 'Vazir',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontFamily: 'Vazir',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[900],
          ),
          titleLarge: TextStyle(
            fontFamily: 'Vazir',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey[800],
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Vazir',
            fontSize: 16,
            color: Colors.blueGrey[700],
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueGrey[100]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueGrey[100]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueGrey[300]!),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red[300]!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red[300]!),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintStyle: TextStyle(
            fontFamily: 'Vazir',
            color: Colors.blueGrey[300],
          ),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/': (_) => const HomeScreen(),
        '/admin-login': (_) => const AdminLoginScreen(),
        '/admin': (_) => const AdminPanelScreen(),
      },
      // onGenerateRoute تا اگر route نداشت خطا نده و home باز شه
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
    );
  }
}
