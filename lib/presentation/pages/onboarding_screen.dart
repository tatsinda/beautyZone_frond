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
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.",
      imageUrl: "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800", // Image Hello
    ),
    OnboardingData(
      title: "Ready?",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      imageUrl: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800", // Image Ready
      isLastPage: true,
    ),
    OnboardingData(
      title: "Hello",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.",
      imageUrl: "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800", // Image Hello
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