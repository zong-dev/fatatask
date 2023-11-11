// ignore_for_file: use_build_context_synchronously

import 'package:fasta/pages/dashboard.dart';
import 'package:fasta/providers/user.dart';
import 'package:fasta/theme.dart';
import 'package:fasta/utils/utils.dart';
import 'package:fasta/widgets/button.dart';
import 'package:fasta/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  late TextEditingController _emailController;
  late TextEditingController _fullnameController;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
        text: context.watch<UserProvider>().email.toString());
    _fullnameController = TextEditingController(
        text: context.watch<UserProvider>().username.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.8),
          child: Container(
            color: AppColors.primary,
            height: 0.8,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                // horizontalSpacer(8),
                // Text(
                //   "Back",
                //   style: GoogleFonts.lato(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextInputField(
                  label: "Full name",
                  controller: _fullnameController,
                  inputType: TextInputType.text,
                ),
                verticalSpacer(16),
                TextInputField(
                  label: "Email",
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                ),
                verticalSpacer(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120,
                      child: ButtonWidget(
                          label: context.watch<UserProvider>().isLoading
                              ? "..."
                              : "Update",
                          onClick: () => updateProfile()),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _fullnameController.dispose();
  }

  updateProfile() async {
    if (_form.currentState!.validate()) {
      var updateStatus = await context.read<UserProvider>().updateAccountData(
          email: _emailController.text, fullname: _fullnameController.text);
      if (updateStatus == true) {
        navigate(context, screen: const DashboardPage());
      } else {
        Fluttertoast.showToast(
            msg: "Invalid Username or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }
}
