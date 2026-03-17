import 'dart:async';
import 'package:beauty_zone/presentation/pages/onboarding_screen.dart' show OnboardingScreen;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});
  @override
  State<InitialSplashScreen> createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> with SingleTickerProviderStateMixin {
  

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // On fait démarrer l'échelle à 0.5 au lieu de 0 pour éviter l'effet "écran vide"
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _controller.forward();

    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
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
      backgroundColor: Colors.white, // Fond blanc forcé
      body: Center( // On centre tout pour éviter que ça sorte de l'écran
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min, // La colonne ne prend que la place nécessaire
            children: [
              // Logo Shoppe
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag, 
                  size: 70, 
                  color: AppColors.primaryBlue, // Bleu Shoppe
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Shoppe',
                style: GoogleFonts.poppins(
                  fontSize: 40, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Beautiful eCommerce UI Kit\nfor your online store',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

}