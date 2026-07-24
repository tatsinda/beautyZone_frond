import 'package:beauty_zone/screen/admin/adminUpdateService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ListServicesScreen extends StatefulWidget {
  const ListServicesScreen({super.key});

  @override
  State<ListServicesScreen> createState() => _ListServicesScreenState();
}

class _ListServicesScreenState extends State<ListServicesScreen> {
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

   String apiUrl = "http://185.213.27.226:9081/api/beautyService/all"; // Remplace par ton IP si nécessaire

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

    return InkWell(
      child: Container(
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
                  item['name'] ?? "Service",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.price_change, size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(item['price'].toString() ?? "--", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(item['extra'] ?? "--", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                
            
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      // Action à effectuer lors du tap sur la carte
      print("Service sélectionné : ${item['name']}");
     

      Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AdminUpdateServiceScreen(data: item,
                                        idService: item['idService'],),
                                  ),
                                );



    },
    );
  }
}