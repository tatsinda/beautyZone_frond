import 'package:beauty_zone/screen/home/widget/CustomBottomNav.dart';
import 'package:beauty_zone/screen/profil/component/OrdersHairSreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // On initialise l'index à 3 (souvent la position du profil dans la barre)
  int _currentIndex = 3;

  // Couleurs du thème
  static const Color primaryPurple = Color(0xFF9156C1);
  static const Color darkPurple = Color(0xFF7B39B6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // On enveloppe le contenu actuel dans un Expanded pour qu'il prenne toute la place
          Expanded(
            child: Stack(
              children: [
                // 1. Fond avec dégradé
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFE1BEE7), Colors.white],
                      stops: [0.0, 0.4],
                    ),
                  ),
                ),
                
                Column(
                  children: [
                    // 2. Custom AppBar
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top, bottom: 15),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryPurple, darkPurple],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {},
                          ),
                          Text(
                            'Beauty Zone',
                            style: GoogleFonts.dancingScript(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.person, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            // 3. Photo de profil
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?q=80&w=1000&auto=format&fit=crop',
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 15),
                            // 4. Informations utilisateur
                            Text(
                              'Laura',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4A148C),
                              ),
                            ),
                            const Text(
                              '+237 653 12 88 54',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            const Text(
                              'laura@example.com',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            
                            const SizedBox(height: 30),
                            // 5. Liste des options
                            _buildProfileOption(
                              icon: Icons.shopping_basket_outlined,
                              title: 'Mes Rendez-vous',
                              onTap: () {
                                print('Mes Rendez-vous tapped');
                                Navigator.pushReplacement(context, 
                                  MaterialPageRoute(builder: (context) => const OrderListScreen())
                                );
                              },
                            ),
                            _buildProfileOption(
                              icon: Icons.shopping_bag_outlined,
                              title: 'Mes Commandes',
                              badge: '3',
                              onTap: () {
                                
                              },
                            ),
                            _buildProfileOption(
                              icon: Icons.card_giftcard_outlined,
                              title: 'Mes Points',
                              trailingText: '7 pts',
                              onTap: () {},
                            ),
                            _buildProfileOption(
                              icon: Icons.chat_bubble_outline,
                              title: 'Mes Avis',
                              onTap: () {},
                            ),
                            _buildProfileOption(
                              icon: Icons.settings_outlined,
                              title: 'À Propos',
                              onTap: () {},
                            ),
                            _buildProfileOption(
                              icon: Icons.history_outlined,
                              title: 'Déconnexion',
                              onTap: () {},
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Insertion de la barre de navigation en bas de la Column
          CustomBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              // Ici, tu pourras ajouter la navigation vers les autres pages
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    String? badge,
    String? trailingText,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.settings_outlined, color: darkPurple, size: 28), // Utilisation de la constante locale
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: darkPurple,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),
      ],
    );
  }
}