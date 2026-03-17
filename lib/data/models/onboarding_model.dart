class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;
  final bool isLastPage;

  OnboardingData({
    required this.title, 
    required this.description, 
    required this.imageUrl, 
    this.isLastPage = false,
  });
}