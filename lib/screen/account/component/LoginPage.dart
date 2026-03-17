import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- CONFIGURATION DES COULEURS (Cohérence Beauty Zone) ---
class AppColors {
  static const Color primaryBlue = Color(0xFF0052FF);
  static const Color fieldGrey = Color(0xFFF7F8F9);
  static const Color textGrey = Color(0xFF8B8B8B);
  static const Color titleBlack = Color(0xFF1E1E1E);
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Formes décoratives en arrière-plan
          Positioned(
            top: -50,
            left: -30,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 2. Contenu du formulaire
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  
                  // Titre et sous-titre
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleBlack,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Good to see you back!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.titleBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.favorite, color: Colors.black, size: 20),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Champs de saisie
                  const CustomLoginField(hintText: 'number'),
                  const SizedBox(height: 20),
                  const CustomLoginField(hintText: 'Password', obscureText: true),

                  const SizedBox(height: 50),

                  // Bouton "Next"
                  ElevatedButton(
                    onPressed: () {
                      // Action de connexion
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Lien mot de passe oublié
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Password forget ? ",
                        style: GoogleFonts.poppins(
                          color: AppColors.textGrey,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Logique de réinitialisation
                        },
                        child: Text(
                          "Reset password",
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET RÉUTILISABLE POUR LES CHAMPS ---
class CustomLoginField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const CustomLoginField({
    super.key,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey[400],
          fontSize: 16,
        ),
        filled: true,
        fillColor: AppColors.fieldGrey,
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}