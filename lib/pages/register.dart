// ignore_for_file: use_build_context_synchronously

import 'package:fasta/pages/pages.dart';
import 'package:fasta/providers/user.dart';
import 'package:fasta/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../widgets/button.dart';
import '../widgets/header.dart';
import '../widgets/input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  late TextEditingController _emailController;
  late TextEditingController _fullnameController;
  late TextEditingController _passwordController;
  bool creatingAccount = false;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullnameController = TextEditingController();
  }

  switchPasswordDisplay() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            child: Form(
              key: _form,
              child: Column(children: [
                const AuthLogo(
                  title: "Sign Up!",
                  subtitle: "Create account with few clicks",
                ),
                verticalSpacer(18),
                TextInputField(
                  label: "Full name",
                  controller: _fullnameController,
                  inputType: TextInputType.text,
                  rules: MultiValidator([
                    RequiredValidator(errorText: "Fullname is required"),
                  ]),
                ),
                verticalSpacer(16),
                TextInputField(
                  label: "Email",
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  rules: MultiValidator([
                    RequiredValidator(errorText: "Email is required"),
                    EmailValidator(errorText: "Enter a valid email address"),
                  ]),
                ),
                verticalSpacer(16),
                TextInputField(
                  label: "Password",
                  controller: _passwordController,
                  inputType: TextInputType.text,
                  obsecureText: hidePassword,
                  suffixIcon: InkWell(
                    onTap: switchPasswordDisplay,
                    child: Container(
                      child: Icon(hidePassword
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill),
                    ),
                  ),
                  rules: MultiValidator([
                    RequiredValidator(errorText: "Password is required"),
                  ]),
                ),
                verticalSpacer(32),
                ButtonWidget(
                    label: context.watch<UserProvider>().isLoading ? "Creating account..." : "Register",
                    onClick: createAccount),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                  child: Divider(
                    color: Colors.black87.withOpacity(.8),
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            // color: AppColors.textFaded,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () =>
                            navigate(context, screen: const LoginPage()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _fullnameController.dispose();
  }

  void createAccount() async {
    if (_form.currentState!.validate()) {
      var accountCreation = await context.read<UserProvider>().createAccount(
          email: _emailController.text,
          password: _passwordController.text,
          fullname: _fullnameController.text);
      if (accountCreation == true) {
        navigate(context,
            screen: const DashboardPage(), type: NavigationType.push);
      } else {
        Fluttertoast.showToast(
        msg: "Service is currently unavailable",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
        // Toast.show("!",
        //     duration: Toast.lengthLong, gravity: Toast.bottom);
      }
    }
  }
}
