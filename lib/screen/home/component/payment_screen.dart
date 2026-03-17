import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- CONFIGURATION DU THÈME ---
class AppColors {
  static const Color primaryPurple = Color(0xFF9156C1); // Couleur dominante
  static const Color backgroundGrey = Color(0xFFF8F9FA);
  static const Color textGrey = Color(0xFF757575);
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        title: Text('Paiement', style: GoogleFonts.poppins(color: Colors.white)),
        actions: const [Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.person, color: Colors.white))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image du service et Détails
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=800"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tresses Africaines', 
                        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('10,000 CFA', 
                        style: GoogleFonts.poppins(fontSize: 20, color: AppColors.primaryPurple, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Icon(Icons.star_half, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text("4,9 (55 avis)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const Divider(height: 40),

                  // 2. SECTION PAIEMENT (Modifications demandées)
                  Text('Mode de paiement', 
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    "Vous pouvez effectuer le paiement complet ou verser une avance pour confirmer votre réservation.",
                    style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textGrey),
                  ),
                  
                  const SizedBox(height: 20),

                  // Sélection MTN / ORANGE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _paymentMethodIcon(
                        "MTN", 
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPQt2OHGAIoJ6B1mx9NGkoe79YKbRp6thAtg&s",
                      ),
                      _paymentMethodIcon(
                        "ORANGE", 
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Orange_logo.svg/1200px-Orange_logo.svg.png",
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Champs de saisie
                  _buildInputField(label: "Numéro de paiement", hint: "Ex: 6xx xxx xxx", icon: Icons.phone),
                  const SizedBox(height: 15),
                  _buildInputField(label: "Montant à verser (CFA)", hint: "Ex: 5000", icon: Icons.money),

                  const SizedBox(height: 40),

                  // Bouton Valider
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text('Confirmer le Paiement', 
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS INTERNES ---

  Widget _paymentMethodIcon(String id, String url) {
    bool isSelected = selectedMethod == id;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = id),
      child: Container(
        width: 100,
        height: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryPurple : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.2), blurRadius: 10)] : [],
        ),
        child: Image.network(url, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primaryPurple),
            hintText: hint,
            filled: true,
            fillColor: AppColors.backgroundGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}