// ignore_for_file: use_build_context_synchronously

import 'package:fasta/pages/pages.dart';
import 'package:fasta/providers/user.dart';
import 'package:fasta/theme.dart';
import 'package:fasta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      AuthStatus authStatus =
          await Provider.of<UserProvider>(context, listen: false)
              .getAuthStatus();
      navigate(context,
          screen: authStatus == AuthStatus.authenticated
              ? const DashboardPage()
              : const LoginPage(),
          type: NavigationType.replace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.sizeOf(context).width * 0.6,
        ),
      ),
    );
  }
}
