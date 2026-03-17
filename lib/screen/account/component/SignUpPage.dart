import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- CONFIGURATION DES COULEURS ---
class AppColors {
  static const Color primaryBlue = Color(0xFF0052FF); // Bleu vif du design
  static const Color fieldGrey = Color(0xFFF7F8F9); // Gris très clair des champs
  static const Color textGrey = Color(0xFF8B8B8B);
  static const Color titleBlack = Color(0xFF1E1E1E);
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Forme décorative bleue à droite
          Positioned(
            top: 130,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 2. Contenu principal
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  // Titre principal
                  Text(
                    'Create\nAccount',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleBlack,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Photo de profil
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 10)
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFFFC1E3), // Rose clair du fond avatar
                            backgroundImage: NetworkImage(
                              'https://api.dicebear.com/7.x/avataaars/png?seed=Felix', // Placeholder style illustration
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

// Champs de saisie réutilisables
                  const CustomInputField(
                    hintText: 'Full Name',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 15),

                  // Champs de saisie réutilisables
                  const CustomInputField(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  const CustomInputField(
                    hintText: 'Password',
                    obscureText: true,
                    suffixIcon: Icons.visibility_off_outlined,
                  ),
                  const SizedBox(height: 15),
                  
                  // Champ numéro de téléphone avec drapeau
                  const PhoneInputField(),

                  const SizedBox(height: 20),

        
                  // Bouton "Done"
                  ElevatedButton(
                    onPressed: () {
                      // Logique de création de compte
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
                      'Done',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- NOUVEAU : LIEN VERS LOGIN ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous avez déjà un compte ? ",
                        style: GoogleFonts.poppins(
                          color: AppColors.textGrey,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Redirection vers la page de Login
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          print("Aller à la page Login");
                        },
                        child: Text(
                          "Se connecter",
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

      
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET RÉUTILISABLE : CHAMP DE SAISIE ---
class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 16),
        filled: true,
        fillColor: AppColors.fieldGrey,
        suffixIcon: suffixIcon != null 
            ? Icon(suffixIcon, color: Colors.grey[400], size: 20) 
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// --- WIDGET : CHAMP TÉLÉPHONE AVEC DRAPEAU ---
class PhoneInputField extends StatelessWidget {
  const PhoneInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fieldGrey,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          // Sélecteur de pays simplifié
          Row(
            children: [
             
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
            ],
          ),
          const SizedBox(width: 10),
          // Barre de séparation
          Container(height: 25, width: 1, color: Colors.grey[300]),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Your number',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}