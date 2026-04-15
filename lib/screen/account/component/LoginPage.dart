import 'dart:convert'; // Nécessaire pour jsonEncode et jsonDecode
import 'dart:io'; // Pour détecter la plateforme
import 'package:beauty_zone/core/theme/app_colors.dart';
import 'package:beauty_zone/screen/home/component/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Importation du package http
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Contrôleurs pour récupérer le texte saisi
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // 2. Fonction de connexion
  Future<void> _login() async {
    setState(() => _isLoading = true);

    // Note sur localhost :
    // Android Emulator utilise 10.0.2.2 au lieu de localhost
    // iOS Simulator utilise localhost
    final String url = Platform.isAndroid
        ? 'http://185.213.27.226:9081/api/login'
        : 'http://185.213.27.226:9081/api/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      print(
        'Login response: ${response.statusCode} - ${response.body}',
      ); // Log pour debug

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        String idUser = responseData['idUser'].toString();

        // 🔥 Sauvegarde dans le "localStorage"
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('idUser', idUser);

        print('ID sauvegardé: ${prefs.getString('idUser')}'); // Log pour vérifier la sauvegarde

        print(
          'Parsed response data: ${responseData['idUser']}',
        ); // Log pour vérifier les données
        // Succès !
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BeautyHomePage()),
          );
        }
      } else {
        // Erreur API (ex: 401 Unauthorized)
        _showError("Identifiants incorrects ou erreur serveur.");
      }
    } catch (e) {
      // Erreur de connexion (Serveur éteint, pas d'internet, etc.)
      _showError("Impossible de contacter le serveur backend.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('idUser');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Formes décoratives (identiques à ton code)
          _buildBackgroundCircle(-50, -30, 250),
          _buildBackgroundCircle(250, null, 180, right: -60),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
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

                  // 3. Utilisation des contrôleurs dans les champs
                  CustomLoginField(
                    hintText: 'email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomLoginField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: _passwordController,
                  ),

                  const SizedBox(height: 50),

                  // 4. Bouton avec indicateur de chargement
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Next',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                  ),

                  const SizedBox(height: 30),
                  // Lien reset (identique)

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

  Widget _buildBackgroundCircle(
    double top,
    double? left,
    double size, {
    double? right,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// --- WIDGET MODIFIÉ POUR ACCEPTER LE CONTROLLER ---
class CustomLoginField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller; // Ajouté

  const CustomLoginField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Liaison ici
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.fieldGrey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
