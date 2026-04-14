import 'package:beauty_zone/screen/home/component/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingBottomSheet extends StatefulWidget {
  const BookingBottomSheet({super.key});

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  int selectedDate = 15;
  String selectedTime = "10:00";

  static const Color darkPurple = Color(0xFF7B39B6);
  static const Color primaryPurple = Color(0xFF9156C1);
  static const Color lightPurple = Color(0xFFE1BEE7);

  @override
  Widget build(BuildContext context) {
    // On utilise DraggableScrollableSheet pour un effet de glissement fluide
    return DraggableScrollableSheet(
      initialChildSize: 0.85, // Hauteur initiale (85% de l'écran)
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
              // Petite barre grise pour indiquer qu'on peut glisser vers le bas
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // En-tête du BottomSheet
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
                    const SizedBox(width: 48), // Équilibre visuel
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

              // Bouton de confirmation fixe en bas du BottomSheet
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {

                   Navigator.pushNamed(context, '/payment');

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Continuer',
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
    // Logique de la grille calendrier (reprise du code précédent)
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((d) => Text(d, style: const TextStyle(color: Colors.grey))).toList(),
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