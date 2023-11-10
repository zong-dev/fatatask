import 'package:fasta/pages/pages.dart';
import 'package:fasta/providers/user.dart';
import 'package:fasta/theme.dart';
import 'package:fasta/utils/utils.dart';
import 'package:fasta/widgets/button.dart';
import 'package:fasta/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../widgets/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool authenticating = false;

  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  bool hidePassword = true;
  switchPasswordDisplay() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Form(
            key: _form,
            child: Column(children: [
              const AuthLogo(
                title: "Welcome Back!",
                subtitle: "Login to Continue",
              ),
              verticalSpacer(18),
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
                  child: Icon(hidePassword
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill),
                ),
                rules: MultiValidator(
                    [RequiredValidator(errorText: "Password is required")]),
              ),
              verticalSpacer(32),
              ButtonWidget(label: authenticating ? "Authenticating..." : "Login", onClick: () => authenticate()),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
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
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          // color: AppColors.textFaded,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () =>
                          navigate(context, screen: const RegisterPage()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            'Sign up',
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  authenticate() async {
    if(_form.currentState!.validate() && !authenticating) {
      setState(() => authenticating = true);

    }
    return;
  }
}
