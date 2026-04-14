import 'package:beauty_zone/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpDigitField extends StatelessWidget {
  final bool first;
  final bool last;
  const OtpDigitField({super.key, required this.first, required this.last});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        autofocus: first,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus(); // Passe au champ suivant
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus(); // Retour en arrière
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppColors.primaryBlue),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: AppColors.primaryBlue),
          ),
        ),
      ),
    );
  }
}