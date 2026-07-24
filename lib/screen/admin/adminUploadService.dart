import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class AdminUploadServiceScreen extends StatefulWidget {
  const AdminUploadServiceScreen({super.key});

  @override
  State<AdminUploadServiceScreen> createState() => _AdminUploadServiceScreenState();
}

class _AdminUploadServiceScreenState extends State<AdminUploadServiceScreen> {
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  // Contrôleurs pour les champs texte
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _extraController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  bool _isUploading = false;

  // Fonction pour choisir une image
  Future<void> _pickImage() async {
    if (_selectedImages.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Maximum 3 photos autorisées")),
      );
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImages.add(File(image.path));
      });
    }
  }

  // Fonction d'envoi vers l'API Spring Boot
  Future<void> _submitData() async {
    if (_selectedImages.length < 3 || _nameController.text.isEmpty || _categoryIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs et ajouter 3 photos")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      var uri = Uri.parse("http://185.213.27.226:9081/api/upload/multiple");
      var request = http.MultipartRequest('POST', uri);

      // 1. Ajout des Meta Datas (RequestParams)
      request.fields['name'] = _nameController.text;
      request.fields['description'] = _descController.text;
      request.fields['price'] = _priceController.text;
      request.fields['categoryId'] = _categoryIdController.text;
      request.fields['extra'] = _extraController.text;
      request.fields['typeMedia'] = "IMAGE2D"; 

      // 2. Ajout des fichiers (List<MultipartFile>)
      // Attention : la clé 'files' doit correspondre au @RequestPart("files") de ton Java
      for (var file in _selectedImages) {
        var multipartFile = await http.MultipartFile.fromPath(
          'files', 
          file.path,
        );
        request.files.add(multipartFile);
      }

      // 3. Envoi de la requête
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Service créé avec succès !"), backgroundColor: Colors.green),
        );
        _clearForm();
      } else {
        print("Erreur: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      setState(() => _isUploading = false);
    }
  }

  void _clearForm() {
    _nameController.clear();
    _descController.clear();
    _priceController.clear();
    _extraController.clear();
    _categoryIdController.clear();
    setState(() => _selectedImages.clear());
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF9156C1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un Service", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Photos du service (3 requises)", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Zone de sélection d'images
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 80, width: 80,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.add_a_photo, color: primaryPurple),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_selectedImages[index], width: 80, height: 80, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            _buildTextField(_nameController, "Nom du service", Icons.edit),
            _buildTextField(_categoryIdController, "ID Catégorie", Icons.category, isNumber: true),
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
                  : const Text("PUBLIER LE SERVICE", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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