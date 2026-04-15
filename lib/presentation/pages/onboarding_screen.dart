import 'package:flutter/material.dart';
import '../widgets/onboarding_page_widget.dart';
import '../../data/models/onboarding_model.dart';
import '../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Hello",
      description: "Coupe, brushing, coloration ou balayage… Nos coiffeuses expertes vous subliment selon vos envies. Réservez votre créneau en un clic !",
      imageUrl: "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800", // Image Hello
    ),
    OnboardingData(
      title: "New Look",
      description: " Nos formules coiffure événementielle (chignon, tresses, boucles) vous garantissent un look parfait qui tient toute la nuit. À vous de briller !",
      imageUrl: "https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?q=80&w=800", // Image Hello
    ),
    OnboardingData(
      title: "coupe nette et moderne",
      description: " Profitez de notre soin complet (coupe + taillage de barbe + shampooing tonique) pour un style affirmé et soigné. Hommes, à vous de jouer !",
      imageUrl: "https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=800", // Image Hello
    ),
    OnboardingData(
      title: "Manucure & pédicure",
      description: " chouchoutez vos mains et vos pieds. Soins cuticules, limage, massage et couleur au choix. Repartez avec des ongles irrésistibles.",
      imageUrl: "https://images.unsplash.com/photo-1604654894610-df63bc536371?q=80&w=800", // Image Hello
    ),
    OnboardingData(
      title: "Ready?",
      description: " Notre formule express  vous offre un résultat impeccable sans attendre. Idéal pour la pause déjeuner et les sorties. Cliquez et venez !",
      imageUrl: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?q=80&w=800", // Image Ready
      isLastPage: true,
    )
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan stylisé (forme bleue en haut à gauche)
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
            ),
          ),
          
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return OnboardingPageWidget(data: _pages[index]);
            },
          ),

          // Indicateurs de pages (Points)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentPage == index ? 25 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.primaryBlue : AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}