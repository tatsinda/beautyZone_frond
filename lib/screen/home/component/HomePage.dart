import 'package:beauty_zone/screen/home/widget/CustomBottomNav.dart';
import 'package:beauty_zone/screen/home/widget/ServiceSection.dart';
import 'package:flutter/material.dart';

class BeautyHomePage extends StatefulWidget {
  const BeautyHomePage({super.key});

  @override
  State<BeautyHomePage> createState() => _BeautyHomePageState();
}

class _BeautyHomePageState extends State<BeautyHomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  int _currentBanner = 0;

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
      "selected": false
    },
    {"title": "Nail Art", "icon": Icons.brush_outlined, "selected": false},
    {"title": "Spa", "icon": Icons.spa_outlined, "selected": false},
  ];

  final Map<String, List<Map<String, String>>> serviceCategories = {
    "Coiffure Homme": [
      {
        "name": "Dégradé Pro",
        "price": "7 000 FCFA",
        "extra": "Très demandé",
        "image":
            "https://images.unsplash.com/photo-1621605815971-fbc98d665033?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Coupe Classique",
        "price": "5 000 FCFA",
        "extra": "30 min",
        "image":
            "https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Twist Homme",
        "price": "9 000 FCFA",
        "extra": "Style tendance",
        "image":
            "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=1200&auto=format&fit=crop",
      },
    ],
    "Coiffure Femme": [
      {
        "name": "Tresses Bohème",
        "price": "15 000 FCFA",
        "extra": "Populaire",
        "image":
            "https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Brushing Luxe",
        "price": "8 000 FCFA",
        "extra": "45 min",
        "image":
            "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Chignon Mariage",
        "price": "20 000 FCFA",
        "extra": "Premium",
        "image":
            "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1200&auto=format&fit=crop",
      },
    ],
    "Soin de Visage": [
      {
        "name": "Glow Face Care",
        "price": "12 000 FCFA",
        "extra": "Peau éclatante",
        "image":
            "https://images.unsplash.com/photo-1515377905703-c4788e51af15?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Nettoyage Profond",
        "price": "10 000 FCFA",
        "extra": "Soin complet",
        "image":
            "https://images.unsplash.com/photo-1556228578-8c89e6adf883?q=80&w=1200&auto=format&fit=crop",
      },
    ],
    "Massage": [
      {
        "name": "Massage Relaxant",
        "price": "18 000 FCFA",
        "extra": "60 min",
        "image":
            "https://images.unsplash.com/photo-1519823551278-64ac92734fb1?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Massage Premium",
        "price": "25 000 FCFA",
        "extra": "Corps complet",
        "image":
            "https://images.unsplash.com/photo-1544161515-4ab6ce6db874?q=80&w=1200&auto=format&fit=crop",
      },
    ],
    "Pose Ongle": [
      {
        "name": "Nail Art Chic",
        "price": "9 000 FCFA",
        "extra": "Longue tenue",
        "image":
            "https://images.unsplash.com/photo-1604654894610-df63bc536371?q=80&w=1200&auto=format&fit=crop",
      },
      {
        "name": "Pose Gel",
        "price": "11 000 FCFA",
        "extra": "Brillance",
        "image":
            "https://images.unsplash.com/photo-1610992015732-2449b76344bc?q=80&w=1200&auto=format&fit=crop",
      },
    ],
  };

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
                    ...serviceCategories.entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 26),
                        child: ServiceSection(
                          title: entry.key,
                          items: entry.value,
                        ),
                      ),
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

  Widget _buildHeader(Color kPurpleFeminine) {
    const textGrey = Color(0xFF8B8B8B);
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined,
                color: kPurpleFeminine, size: 22),
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
            Icon(Icons.keyboard_arrow_down_rounded,
                color: textGrey, size: 22),
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
            controller: PageController(),
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBanner = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(banner["image"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                      const SizedBox(height: 2),
                      Text(
                        banner["subtitle"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        banner["description"]!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      
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
              mainAxisSize: MainAxisSize.min,
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