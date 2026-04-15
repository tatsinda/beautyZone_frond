import 'package:beauty_zone/screen/account/component/SignUpPage.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPageWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
        ),
        child: Column(
          children: [
            // Image arrondie
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage(data.imageUrl), fit: BoxFit.cover),
                ),
              ),
            ),
            
            // Texte informatif
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      data.title,
                      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      data.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.grey, fontSize: 16, height: 1.5),
                    ),
                    const Spacer(),
                    
                    // Bouton "Let's Start" uniquement sur la dernière page
                    if (data.isLastPage)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigation vers l'écran suivant (ex: Profil ou Commandes)
                           Navigator.pushNamed(context, '/signup');

                      

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: const Text("Let's Start", style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}