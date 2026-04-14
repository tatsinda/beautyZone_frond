import 'package:beauty_zone/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildBeautyAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          // Exemple de données dynamiques
          return OrderCard(
            orderId: "92287157",
            status: index < 2 ? "Shipped" : "Delivered",
            itemCount: index + 1,
            images: const [
              'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=100',
              'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=100',
              'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=100',
              'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=100',
            ],
            onActionPressed: () => print("Action sur commande $index"),
          );
        },
      ),
    );
  }

  // AppBar réutilisable (Design Beauty Zone)
  PreferredSizeWidget _buildBeautyAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.primaryPurple, AppColors.darkPurple]),
        ),
      ),
      leading: const Icon(Icons.menu, color: Colors.white),
      centerTitle: true,
      title: Text('Beauty Zone', style: GoogleFonts.dancingScript(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      actions: const [Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.person, color: Colors.white))],
    );
  }
}

// --- WIDGET RÉUTILISABLE : CARTE DE COMMANDE ---
class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final int itemCount;
  final List<String> images;
  final VoidCallback onActionPressed;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.itemCount,
    required this.images,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isDelivered = status == "Delivered";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Grille d'images (Thumbnail)
          _OrderImageGrid(images: images),
          
          const SizedBox(width: 12),

          // 2. Section Texte et Bouton (Expanded pour éviter l'overflow)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne du haut : Numéro et nombre d'items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text("Order #$orderId", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                    _ItemCountBadge(count: itemCount),
                  ],
                ),
                const Text("Standard Delivery", style: TextStyle(color: Colors.grey, fontSize: 12)),
                
                const SizedBox(height: 12),

                // Ligne du bas : Statut et Bouton (Alignés grâce à MainAxisAlignment.spaceBetween)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end, // Aligne le bouton en bas
                  children: [
                    Row(
                      children: [
                        Text(status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        if (isDelivered) const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.check_circle, color: AppColors.accentBlue, size: 18)),
                      ],
                    ),
                    _OrderActionButton(isDelivered: isDelivered, onPressed: onActionPressed),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- SOUS-WIDGETS ---

class _OrderImageGrid extends StatelessWidget {
  final List<String> images;
  const _OrderImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
        itemCount: images.length > 4 ? 4 : images.length,
        itemBuilder: (_, i) => Image.network(images[i], fit: BoxFit.cover),
      ),
    );
  }
}

class _ItemCountBadge extends StatelessWidget {
  final int count;
  const _ItemCountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(6)),
      child: Text("$count ${count > 1 ? 'items' : 'item'}", style: const TextStyle(fontSize: 11, color: Colors.black54)),
    );
  }
}

class _OrderActionButton extends StatelessWidget {
  final bool isDelivered;
  final VoidCallback onPressed;

  const _OrderActionButton({required this.isDelivered, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (isDelivered) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accentBlue,
          side: const BorderSide(color: AppColors.accentBlue),
          minimumSize: const Size(80, 36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("Review"),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(80, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text("Track"),
    );
  }
}