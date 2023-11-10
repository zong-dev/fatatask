import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

class AuthLogo extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthLogo({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon.png',
          width: 56,
        ),
        horizontalSpacer(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text(
              subtitle,
              style:
                  GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
