import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Couleurs du thème extraites de la maquette
  static const Color primaryPurple = Color(0xFF9156C1);
  static const Color darkPurple = Color(0xFF7B39B6);
  static const Color bgLightPurple = Color(0xFFF8F0FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Fond avec dégradé et vagues
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
              // 2. Custom AppBar avec dégradé
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 15),
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
                      
                      // 5. Liste des boutons/options
                      _buildProfileOption(
                        icon: Icons.shopping_basket_outlined,
                        title: 'Mes Rendez-vous',
                        onTap: () {},
                      ),
                      _buildProfileOption(
                        icon: Icons.shopping_bag_outlined,
                        title: 'Mes Commandes',
                        badge: '3',
                        onTap: () {},
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
            child: Icon(icon, color: darkPurple, size: 28),
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