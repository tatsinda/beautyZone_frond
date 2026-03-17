import 'package:beauty_zone/screen/home/widget/ServiceCard.dart';
import 'package:flutter/material.dart';

class ServiceSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;

  const ServiceSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 380 ? 160.0 : 175.0;

    final screenHeight = MediaQuery.of(context).size.height;
final sectionHeight = screenHeight < 700 ? 210.0 : 240.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: textDark,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: sectionHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return ServiceCard(
                item: items[index],
                width: cardWidth,
              );
            },
          ),
        ),
      ],
    );
  }
}