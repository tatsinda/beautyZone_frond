import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// --- CONFIGURATION DU THÈME ---
class AppColors {
  static const Color primaryPurple = Color(0xFF9156C1);
  static const Color backgroundGrey = Color(0xFFF8F9FA);
  static const Color textGrey = Color(0xFF757575);
}

class PaymentScreen extends StatefulWidget {
  final Map<String, String> item;
  const PaymentScreen({super.key, required this.item});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;
  bool isLoading = false;

  // Controllers pour récupérer le texte des champs
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Fonction pour envoyer la requête de paiement
  Future<void> _handlePayment() async {
    if (selectedMethod == null || _phoneController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs et choisir un mode de paiement")),
      );
      return;
    }

    setState(() => isLoading = true);

    const String apiUrl = "http://185.213.27.226:9081/api/payment";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phoneNumber": _phoneController.text,
          "amount": _amountController.text,
          "idUser": int.parse(widget.item['idUser']!),
          "idService": int.parse(widget.item['idService']!),
        }),
      );

      

      if (response.statusCode == 200) {
        print("Paiement initié avec succès : ${response.body}");
        _showSuccessDialog();
      } else {
        throw Exception("Erreur lors du paiement");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : ${e.toString()}"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Fonction pour afficher le Popup de succès
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              Text(
                "Succès !",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Le paiement a été initié avec succès. Vous recevrez une notification de confirmation sous peu.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le popup
                  Navigator.of(context).pop(); // Retourne à l'écran précédent
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Fermer", style: TextStyle(color: Colors.white)),
              ),
            ],
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
        backgroundColor: AppColors.primaryPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Paiement', style: GoogleFonts.poppins(color: Colors.white)),
        actions: const [Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.person, color: Colors.white))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${widget.item['image']}'),
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
                      Text('${widget.item['name']}', 
                        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('${widget.item['price']}', 
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
                  Text('Mode de paiement', 
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    "Vous pouvez effectuer le paiement complet ou verser une avance pour confirmer votre réservation.",
                    style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 20),
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
                  _buildInputField(
                    label: "Numéro de paiement", 
                    hint: "Ex: 6xx xxx xxx", 
                    icon: Icons.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    label: "Montant à verser (CFA)", 
                    hint: "Ex: 5000", 
                    icon: Icons.money,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: isLoading ? null : _handlePayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      disabledBackgroundColor: Colors.grey,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Confirmer le Paiement', 
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

  Widget _buildInputField({
    required String label, 
    required String hint, 
    required IconData icon, 
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
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