import 'package:fasta/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function onClick;
  const ButtonWidget({super.key, required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      splashColor: const Color.fromARGB(255, 168, 138, 213)
          .withBlue(244)
          .withOpacity(.6),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        height: 54,
        width: double.maxFinite,
        child: Center(
            child: Text(
          label,
          style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.background),
        )),
      ),
    );
  }
}
