import 'dart:convert';
import 'package:beauty_zone/core/theme/app_colors.dart';
import 'package:beauty_zone/presentation/pages/otp_screen.dart';
import 'package:beauty_zone/screen/account/component/LoginPage.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Import indispensable

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 1. Définition des contrôleurs pour récupérer les saisies
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  bool _isLoading = false;

  // 2. Fonction de communication avec l'API
  Future<void> _handleSignUp() async {
    setState(() => _isLoading = true);

    const String url = 'http://185.213.27.226:9081/api/register/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "whatsappNumber": _phoneController.text.trim(),
          "password": _passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(  'Inscription réussie: ${response.statusCode} - ${response.body}'); // Log pour debug
        // Inscription réussie -> Direction OTP
        if (mounted) {
          Navigator.pushNamed(context, '/home');
          Navigator.pop(context);
        }
      } else {
        // Afficher l'erreur retournée par le backend
        _showError("Erreur lors de l'inscription. Vérifiez vos informations.");
      }
    } catch (e) {
      _showError("Impossible de joindre le serveur. Vérifiez votre connexion.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Forme décorative bleue
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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
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
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFFFC1E3),
                        backgroundImage: NetworkImage('https://vip-espace-coiffure.com/wp-content/uploads/2022/10/Posts-VIP-4.png'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Champs de saisie liés aux contrôleurs
                  CustomInputField(
                    hintText: 'Full Name',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    hintText: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    suffixIcon: Icons.visibility_off_outlined,
                  ),
                  const SizedBox(height: 15),
                  
                  // Champ numéro de téléphone
                  PhoneInputField(controller: _phoneController),

                  const SizedBox(height: 20),

                  // Bouton "Done" avec état de chargement
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                    ),
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Done',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  ),

                  const SizedBox(height: 20),

                  // Lien vers Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous avez déjà un compte ? ",
                        style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
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

// --- WIDGET RÉUTILISABLE MODIFIÉ ---
class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller; // Ajouté

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Liaison
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 16),
        filled: true,
        fillColor: AppColors.fieldGrey,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[400], size: 20) : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// --- WIDGET TÉLÉPHONE MODIFIÉ ---
class PhoneInputField extends StatelessWidget {
  final TextEditingController controller; // Ajouté

  const PhoneInputField({super.key, required this.controller});

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
          const Row(
            children: [
              Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
            ],
          ),
          const SizedBox(width: 10),
          Container(height: 25, width: 1, color: Colors.grey[300]),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: controller, // Liaison
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