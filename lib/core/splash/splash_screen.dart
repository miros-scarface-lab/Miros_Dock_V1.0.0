import 'package:flutter/material.dart';
import 'package:miros_share_and_web_dock/features/send/screens/send_home_screen.dart';
import 'package:miros_share_and_web_dock/features/send/core/theme/app_theme.dart';

class UniversalSplashScreen extends StatefulWidget {
  const UniversalSplashScreen({super.key});

  @override
  State<UniversalSplashScreen> createState() => _UniversalSplashScreenState();
}

class _UniversalSplashScreenState extends State<UniversalSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Show splash for 3 seconds total
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SendHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberColors.backgroundStatic,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine if we should show landscape or portrait based on aspect ratio
              final bool isLandscape = constraints.maxWidth > constraints.maxHeight;
              final String assetPath = isLandscape 
                  ? 'assets/splash/landscape.png' 
                  : 'assets/splash/portrait.png';

              return Image.asset(
                assetPath,
                fit: BoxFit.cover,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              );
            },
          ),
        ),
      ),
    );
  }
}
