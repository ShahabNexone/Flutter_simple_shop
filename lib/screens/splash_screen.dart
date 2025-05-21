import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    
    // Start animation
    _controller.forward();
    
    // Navigate to home after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 100,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Nexo Shop',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey[900],
                  fontFamily: 'Vazir',
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'فروشگاه آنلاین هوشمند',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey[700],
                  fontFamily: 'Vazir',
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'لطفاً صبر کنید...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey[400],
                  fontFamily: 'Vazir',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
