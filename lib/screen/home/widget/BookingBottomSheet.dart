import 'package:beauty_zone/screen/home/component/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Import pour le service HTTP
import 'dart:convert'; // Pour l'encodage JSON
import 'package:intl/intl.dart';


class BookingBottomSheet extends StatefulWidget {
  final String idUser;
  final String idService;
  final Map<String, String> item;
  const BookingBottomSheet({super.key, required this.idUser, required this.idService, required this.item});

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  int selectedDate = 15;
  String selectedTime = "10:00";
  bool isLoading = false; // Pour gérer l'état du bouton

  static const Color darkPurple = Color(0xFF7B39B6);
  static const Color primaryPurple = Color(0xFF9156C1);
  static const Color lightPurple = Color(0xFFE1BEE7);

  // Fonction de communication avec l'API
  Future<void> _confirmBooking() async {
    setState(() => isLoading = true);

    const String apiUrl = "http://185.213.27.226:9081/api/appointments"; // 10.0.2.2 pour l'émulateur Android

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "idService": int.parse(widget.idService),
          "date": selectedDate, // Format "int" en String comme demandé
          "time": selectedTime,
          "idUser": int.parse(widget.idUser),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Succès
        if (mounted) { 
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('MMMM yyyy', 'fr_FR').format(now);
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("Réservation confirmée pour le $selectedDate $formattedDate à $selectedTime !"), 
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            elevation: 10,
          ),
          );

          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              item: widget.item,
            ),
          ),
        );
          //Navigator.pop(context); // Ferme le bottom sheet
        }
      } else {
        // Erreur Backend
        throw Exception("Erreur lors de la réservation");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : ${e.toString()}"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Choisir la Date',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCalendarSection(),
                    const Divider(height: 40, thickness: 1),
                    _buildTimeSection(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: isLoading ? null : _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    disabledBackgroundColor: Colors.grey,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Confirmer la Réservation',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((d) => Text(d, style: const TextStyle(color: Colors.grey)))
              .toList(),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemCount: 30,
          itemBuilder: (context, index) {
            int day = index + 1;
            bool isSelected = selectedDate == day;
            return GestureDetector(
              onTap: () => setState(() => selectedDate = day),
              child: Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? darkPurple : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$day',
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    final List<String> times = ["10:00", "11:00", "12:00", "14:30", "12:30"];
    return Column(
      children: [
        Text(
          'Choisir l’Heure',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: times.map((time) {
            bool isSelected = selectedTime == time;
            return GestureDetector(
              onTap: () => setState(() => selectedTime = time),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? darkPurple : lightPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected ? Colors.white : darkPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}