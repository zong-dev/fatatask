import 'package:fasta/pages/profile.dart';
import 'package:fasta/providers/user.dart';
import 'package:fasta/theme.dart';
import 'package:fasta/utils/utils.dart';
import 'package:fasta/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Authenticated User",
              style:
                  GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            verticalSpacer(12),
            Text(
              context.watch<UserProvider>().username ?? '',
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w800),
            ),
            verticalSpacer(20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: ButtonWidget(
                label: "Edit Profile",
                onClick: () => navigate(context,
                    screen: const ProfilePage(), type: NavigationType.push),
              ),
            )
          ],
        ),
      )),
    );
  }
}
