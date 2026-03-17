import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF0F0F0)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_filled,
            label: "Home",
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.calendar_month_outlined,
            label: "Bookings",
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.favorite_border,
            label: "Favourites",
            index: 2,
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            label: "Profile",
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {

    const primaryColor = Color(0xFF9156C1);
    const inactiveColor = Color(0xFF9C9C9C);
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: selected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : inactiveColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: selected ? primaryColor : inactiveColor,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}