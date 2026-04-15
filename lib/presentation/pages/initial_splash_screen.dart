import 'dart:async';
import 'package:beauty_zone/presentation/pages/onboarding_screen.dart'
    show OnboardingScreen;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_colors.dart';

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});
  @override
  State<InitialSplashScreen> createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () async {
      // Réduit à 4s pour une meilleure UX
      if (mounted) {
        final prefs = await SharedPreferences.getInstance();
        String? firstConnexion = prefs.getString('firstConnexion');

        if (firstConnexion != null) {
          // ancienne connexion -> verifier son login
          String? idUser = prefs.getString('idUser');

          if (idUser != null) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/signup');
          }

        } else {
          // Nouvelle connexion -> Aller au OnboardingScreen
          await prefs.setString('firstConnexion', 'true');
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }

  

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
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- LOGO CONTAINER ---
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 25,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    75,
                  ), // Assure que l'image reste ronde
                  child: Padding(
                    padding: const EdgeInsets.all(
                      0,
                    ), // Marge interne pour que le logo ne touche pas les bords
                    child: Image.asset(
                      'assets/images/log.png', // Chemin de ton logo
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // -----------------------
              const SizedBox(height: 25),
              Text(
                'BeautyZone',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E1E1E), // Noir élégant
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Votre salon de beauté digital\nà portée de main',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
