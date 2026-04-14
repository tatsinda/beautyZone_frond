import 'dart:async';
import 'package:beauty_zone/screen/home/component/HomePage.dart';
import 'package:beauty_zone/screen/home/component/OtherHome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Assure-toi que ce chemin est correct selon ton projet
import 'package:beauty_zone/core/theme/app_colors.dart'; 
import '../widgets/otp_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;
  bool _isLoading = false; 

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _secondsRemaining = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() => _canResend = true);
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // --- LOGIQUE DE VÉRIFICATION ET POPUP ---
  void _handleVerification() async {
    setState(() => _isLoading = true);

    // Simulation d'appel API (2 secondes)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 80),
                const SizedBox(height: 20),
                Text(
                  "Vérification Réussie !",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Votre compte a été créé avec succès. Bienvenue chez Beauty Zone.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Continuer", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      // Le secret est ici : on utilise une Column dans un SingleChildScrollView
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Illustration
            Center(
              child: Image.network(
                'https://img.freepik.com/free-vector/otp-authentication-concept-illustration_114360-9110.jpg',
                height: 220,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "OTP Verification",
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                children: const [
                  TextSpan(text: "Enter the code sent to "),
                  TextSpan(text: "+237 6xx xxx xxx", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Champs OTP
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpDigitField(first: true, last: false),
                OtpDigitField(first: false, last: false),
                OtpDigitField(first: false, last: false),
                OtpDigitField(first: false, last: true),
              ],
            ),
            const SizedBox(height: 40),

            // Compte à rebours
            if (!_canResend)
              Text(
                "Renvoyer le code dans 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive code? "),
                GestureDetector(
                  onTap: _canResend ? _startTimer : null,
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      color: _canResend ? AppColors.primaryBlue : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // BOUTON VERIFY AVEC LOADING
            ElevatedButton(
              onPressed: _isLoading ? null : _handleVerification,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                    )
                  : const Text(
                      "Verify",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}