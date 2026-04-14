import 'package:beauty_zone/screen/home/widget/CustomBottomNav.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // L'index 1 correspond généralement aux favoris dans une barre à 4 ou 5 icônes
  int _currentIndex = 1; 

  @override
  Widget build(BuildContext context) {
    // On garde les mêmes constantes de couleurs pour la cohérence
    const Color kPurpleFeminine = Color(0xFF9156C1);
    const Color textDark = Color(0xFF1E1E1E);
    const Color textGrey = Color(0xFF8B8B8B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER (Style identique à HomePage) ---
                    _buildHeader(kPurpleFeminine, textGrey),
                    
                    const SizedBox(height: 60),

                    // --- CONTENU DE MAINTENANCE ---
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image d'illustration professionnelle (Maintenance/Design)
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://images.unsplash.com/photo-1614332287897-cdc485fa562d?q=80&w=1200&auto=format&fit=crop"
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),

                          // Texte de titre
                          const Text(
                            "Mes Favoris",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                          
                          const SizedBox(height: 16),

                          // Message d'alerte
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Bientôt disponible : cette section est actuellement en cours de développement pour vous offrir une meilleure expérience.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: textGrey.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Petit indicateur visuel (Optionnel)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: kPurpleFeminine.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Working on it 🛠️",
                              style: TextStyle(
                                color: kPurpleFeminine,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- NAVIGATION BAR ---
            CustomBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                // Logique pour retourner à l'accueil si on clique sur l'index 0
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, '/home2');
                }
                // Ajoute ici les autres redirections vers /profil, etc.
              },
            ),
          ],
        ),
      ),
    );
  }

  // Header réutilisé pour garder l'identité visuelle de l'app
  Widget _buildHeader(Color kPurpleFeminine, Color textGrey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Beauty Zone",
              style: TextStyle(
                fontSize: 14,
                color: kPurpleFeminine,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const Text(
              "Favoris",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
        // Petit bouton retour ou notification
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEDEDED)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
          ),
        ),
      ],
    );
  }
}