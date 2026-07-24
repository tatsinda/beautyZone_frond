import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserReservationsScreen extends StatefulWidget {
  const UserReservationsScreen({super.key});

  @override
  State<UserReservationsScreen> createState() => _UserReservationsScreenState();
}

class _UserReservationsScreenState extends State<UserReservationsScreen> {
  List<dynamic> reservations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  // Fonction pour récupérer les données de l'API
  Future<void> fetchReservations() async {

    final prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser');

   String apiUrl = "http://185.213.27.226:9081/api/beautyService/appointment/$idUser"; // Remplace par ton IP si nécessaire

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          reservations = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Erreur lors de la récupération des réservations");
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur de connexion : ${e.toString()}"), backgroundColor: Colors.red),
      );
    }
  }

  // Fonction utilitaire pour gérer les couleurs selon le statut
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmé':
      case 'confirme':
        return Colors.green;
      case 'en attente':
        return Colors.orange;
      case 'terminé':
      case 'termine':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF9156C1);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: primaryPurple,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: Text('Beauty Zone', 
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.person, color: Colors.white),
          )
        ],
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator(color: primaryPurple))
        : reservations.isEmpty
            ? Center(child: Text("Aucune réservation trouvée", style: GoogleFonts.poppins()))
            : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final item = reservations[index];
                  return _buildAppointmentCard(item, primaryPurple);
                },
              ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> item, Color primaryColor) {
    // On récupère la couleur dynamiquement
    final Color statusColor = _getStatusColor(item['status'] ?? "");

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Image du produit/service
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              item['image'] ?? "https://via.placeholder.com/150",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          
          // 2. Détails de la réservation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['serviceName'] ?? "Service",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(item['date'] ?? "--", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(item['time'] ?? "--", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                
                // 3. Statut et Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item['status'] ?? "Inconnu",
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Action pour voir les détails
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        minimumSize: const Size(0, 32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Détails", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}