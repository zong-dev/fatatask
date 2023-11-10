import 'package:fasta/theme.dart';
import 'package:fasta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? inputType;
  final FormFieldValidator? rules;
  final Widget? suffixIcon;
  final bool obsecureText;

  final TextInputAction action;

  const TextInputField({
    super.key,
    required this.label,
    required this.controller,
    this.inputType,
    this.rules,
    this.suffixIcon,
    this.obsecureText = false,
    this.action = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpacer(6),
          TextFormField(
            keyboardType: inputType,
            validator: rules,
            obscureText: obsecureText,
            textInputAction: action,
            // cursorColor: AppColors.primary,
            decoration: InputDecoration(
               contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary, width: 1.4),
                gapPadding: 0,
              ),
              fillColor: Theme.of(context).cardColor,
              filled: true,
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: AppColors.primary.withOpacity(.8), width: 1.4),
              ),
              suffixIcon: suffixIcon,
            ),
            controller: controller,
            autocorrect: false,
          ),
        ],
      ),
    );
  }
}
