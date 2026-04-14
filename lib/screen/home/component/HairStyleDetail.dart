import 'package:beauty_zone/screen/home/widget/BookingBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HairStyleDetailScreen extends StatelessWidget {
  const HairStyleDetailScreen({super.key});

  // Couleurs exactes extraites de la maquette
  static const Color primaryPurple = Color(0xFF9156C1);
  static const Color lightPurpleBg = Color(0xFFF3E5F5);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color pricePurple = Color(0xFF7B39B6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Top Bar
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 10),
            decoration: const BoxDecoration(
              color: primaryPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  onPressed: () {},
                ),
                Text(
                  'Beauty Zone',
                  style: GoogleFonts.dancingScript(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image principale avec pagination
                  Stack(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=800',
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Row(
                          children: List.generate(3, (index) => Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: index == 0 ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tresses',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                              ),
                            ),
                            Icon(Icons.favorite_border, color: Colors.grey.shade300, size: 30),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '10,000 CFA',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: pricePurple,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Des tresses africaines avec des longueurs allant jusqu’au bas du dos, idéales pour un look stylé et moderne.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Galerie de miniatures
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildThumbnail('https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=200'),
                            _buildThumbnail('https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1?w=200'),
                            _buildThumbnail('https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=200'),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Rating
                        Row(
                          children: [
                            ...List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 20)),
                            const SizedBox(width: 10),
                            const Text(
                              '4,9',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '55 rangs',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 100), // Espace pour le bouton
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Bouton fixe en bas
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
          showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Indispensable pour que le contenu puisse prendre plus de place
    backgroundColor: Colors.transparent, // Pour gérer nos propres arrondis
    builder: (context) => const BookingBottomSheet(),
  );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPurple,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text(
            'Prendre Rendez-vous',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}