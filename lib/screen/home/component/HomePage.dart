import 'package:beauty_zone/screen/account/component/LoginPage.dart';
import 'package:beauty_zone/screen/home/widget/CustomBottomNav.dart';
import 'package:beauty_zone/screen/home/widget/ServiceSection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import pour les appels API
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'; // Import pour le décodage JSON

class BeautyHomePage extends StatefulWidget {
  const BeautyHomePage({super.key});

  @override
  State<BeautyHomePage> createState() => _BeautyHomePageState();
}

class _BeautyHomePageState extends State<BeautyHomePage> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();
  int _currentBanner = 0;

  // Variables pour gérer l'état des données
  bool _isLoading = true;
  Map<String, List<Map<String, String>>> serviceCategories = {};

  final List<Map<String, String>> banners = [
    {
      "title": "Salon Promo",
      "subtitle": "Fresh Look",
      "description": "Book your appointment in one click",
      "image":
          "https://images.unsplash.com/photo-1560066984-138dadb4c035?q=80&w=1200&auto=format&fit=crop",
    },
    {
      "title": "Morning Special",
      "subtitle": "Get 20% Off",
      "description": "On selected haircuts this morning",
      "image":
          "https://images.unsplash.com/photo-1517832606299-7ae9b720a186?q=80&w=1200&auto=format&fit=crop",
    },
    {
      "title": "Beauty Offer",
      "subtitle": "New Styles",
      "description": "Discover premium beauty services",
      "image":
          "https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?q=80&w=1200&auto=format&fit=crop",
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"title": "Hair Cut", "icon": Icons.content_cut, "selected": true},
    {
      "title": "Hair Styling",
      "icon": Icons.face_retouching_natural,
      "selected": false,
    },
    {"title": "Nail Art", "icon": Icons.brush_outlined, "selected": false},
    {"title": "Spa", "icon": Icons.spa_outlined, "selected": false},
  ];

  @override
  void initState() {
    super.initState();
    _fetchServiceCategories(); // Appel de l'API au chargement
  }

  // Fonction de communication HTTP
  Future<void> _fetchServiceCategories() async {
    final prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser');
    // Remplace par ton IP si tu testes sur un téléphone physique (ex: 192.168.x.x)
    // Ou 10.0.2.2 pour l'émulateur Android vers localhost
    final String url =
        'http://185.213.27.226:9081/api/beautyService/categories/$idUser';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Décodage des données
        final Map<String, dynamic> decodedData = json.decode(
          utf8.decode(response.bodyBytes),
        );

        setState(() {
          serviceCategories = decodedData.map((key, value) {
            return MapEntry(
              key,
              List<Map<String, String>>.from(
                (value as List).map((item) => Map<String, String>.from(item)),
              ),
            );
          });
          _isLoading = false;
        });
      } else {
        throw Exception('Erreur lors du chargement des services');
      }
    } catch (e) {
      print("Erreur API: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color kPurpleFeminine = Color(0xFF9156C1);
    const Color textDark = Color(0xFF1E1E1E);
    const Color textGrey = Color(0xFF8B8B8B);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(kPurpleFeminine),
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 20),
                    _buildBannerSlider(kPurpleFeminine, textDark),
                    const SizedBox(height: 28),
                    const Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCategoryTabs(kPurpleFeminine, textGrey),
                    const SizedBox(height: 28),

                    // Gestion de l'affichage pendant le chargement
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: kPurpleFeminine,
                            ),
                          )
                        : Column(
                            children: serviceCategories.entries
                                .map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.only(bottom: 26),
                                    child: ServiceSection(
                                      title: entry.key,
                                      items: entry.value,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
            CustomBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Garder le reste des méthodes (_buildHeader, _buildSearchBar, etc.) identiques ---

  Widget _buildHeader(Color kPurpleFeminine) {
    const textGrey = Color(0xFF8B8B8B);
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: kPurpleFeminine, size: 22),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                "Location",
                style: TextStyle(
                  fontSize: 13,
                  color: textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEDEDED)),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: textGrey,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 11,
                    right: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5A4E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: const [
            SizedBox(width: 30),
            Expanded(
              child: Text(
                "Lakewood, California",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: textGrey,
                ),
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.keyboard_arrow_down_rounded, color: textGrey, size: 22),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          SizedBox(width: 14),
          Icon(Icons.search, color: Color(0xFFA8A8A8), size: 22),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter address or city name",
                hintStyle: TextStyle(
                  color: Color(0xFFA8A8A8),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSlider(Color kPurpleFeminine, Color textDark) {
    return SizedBox(
      height: 132,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: banners.length,
            onPageChanged: (index) => setState(() => _currentBanner = index),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(banner["image"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        kPurpleFeminine.withOpacity(0.78),
                        Colors.black.withOpacity(0.18),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner["title"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        banner["subtitle"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        banner["description"]!,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 16,
            child: Row(
              children: List.generate(
                banners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(right: 6),
                  width: _currentBanner == index ? 18 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: _currentBanner == index
                        ? Colors.white
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(Color kPurpleFeminine, Color textGrey) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = categories[index];
          final bool selected = item["selected"] as bool;
          return Container(
            constraints: const BoxConstraints(minWidth: 110),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: selected ? kPurpleFeminine : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: selected
                  ? null
                  : Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Row(
              children: [
                Icon(
                  item["icon"] as IconData,
                  size: 18,
                  color: selected ? Colors.white : textGrey,
                ),
                const SizedBox(width: 8),
                Text(
                  item["title"] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : textGrey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
