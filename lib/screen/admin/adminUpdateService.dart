import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminUpdateServiceScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final int idService;

  const AdminUpdateServiceScreen({
    super.key,
    required this.data,
    required this.idService,
  });

  @override
  State<AdminUpdateServiceScreen> createState() => _AdminUpdateServiceScreenState();
}

class _AdminUpdateServiceScreenState extends State<AdminUpdateServiceScreen> {
 

  // Contrôleurs pour les champs texte
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _extraController;

  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs avec les données reçues
    // On utilise toString() pour s'assurer que les prix ou ID (nombres) deviennent du texte
    _nameController = TextEditingController(text: widget.data['name'] ?? "");
    _descController = TextEditingController(text: widget.data['description'] ?? "");
    _priceController = TextEditingController(text: widget.data['price']?.toString() ?? "");
    _extraController = TextEditingController(text: widget.data['extra'] ?? "");
  }

  @override
  void dispose() {
    // Il est important de libérer la mémoire des contrôleurs
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _extraController.dispose();
    super.dispose();
  }


  Future<void> _submitData() async {
    // Note : Pour une mise à jour, on autorise parfois à ne pas changer les photos
    if (_nameController.text.isEmpty || _priceController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir au moins le nom et le prix")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Correction de l'URL avec widget.idService
      final String url = 'http://185.213.27.226:9081/api/update/${widget.idService}';
      
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'extra': _extraController.text,
          'description': _descController.text,
          'price': _priceController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Service mis à jour avec succès !"), backgroundColor: Colors.green),
        );
        Navigator.pop(context); // Retourner à l'écran précédent après succès
      } else {
        print("Erreur: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF9156C1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier le Service", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            const SizedBox(height: 25),
            _buildTextField(_nameController, "Nom du service", Icons.edit),
            _buildTextField(_priceController, "Prix", Icons.attach_money, isNumber: true),
            _buildTextField(_descController, "Description", Icons.description, maxLines: 3),
            _buildTextField(_extraController, "Extra (Options)", Icons.star_border),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isUploading ? null : _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: _isUploading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("METTRE À JOUR", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF9156C1)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}