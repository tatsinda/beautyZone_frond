import 'package:beauty_zone/screen/home/component/HairStyleDetail.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final Map<String, String> item;
  final double width;

  const ServiceCard({
    super.key,
    required this.item,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    
    const primaryColor = Color(0xFF9156C1);
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF8B8B8B);

    final screenHeight = MediaQuery.of(context).size.height;
final imageHeight = screenHeight < 700 ? 95.0 : 120.0;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          print('Tapped on ${item['name']}');
     

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HairStyleDetailScreen(item: item),
          ),
        );
              
        },
        borderRadius: BorderRadius.circular(18),
        child:  Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          ClipRRect(

            borderRadius: const BorderRadius.vertical(

              top: Radius.circular(18),

            ),

            child: Image.network(

              item['image']!,

              height: imageHeight,

              width: double.infinity,

              fit: BoxFit.cover,

            ),

          ),

          Padding(

            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  item['name']!,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(

                    fontSize: 16,

                    fontWeight: FontWeight.w700,

                    color: textDark,

                  ),

                ),

                const SizedBox(height: 6),

                Text(

                  item['price']!,

                  style: const TextStyle(

                    fontSize: 15,

                    fontWeight: FontWeight.w700,

                    color: primaryColor,

                  ),

                ),

                const SizedBox(height: 3),

                Text(

                  item['extra']!,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(

                    fontSize: 13,

                    color: textGrey,

                    fontWeight: FontWeight.w500,

                  ),

                ),

                const SizedBox(height: 2),

                Row(

                  children: const [

                    Icon(

                      Icons.star_rounded,

                      size: 17,

                      color: Color(0xFFFFC107),

                    ),

                    SizedBox(width: 4),

                    Text(

                      '4.8',

                      style: TextStyle(

                        fontSize: 13,

                        fontWeight: FontWeight.w600,

                        color: textDark,

                      ),

                    ),

                  ],

                ),

              ],

            ),

          ),

        ],

      )
      ),
    );
  }
}