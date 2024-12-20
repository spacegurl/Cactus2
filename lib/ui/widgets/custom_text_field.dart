import 'package:flutter/material.dart';
import '../../core/core.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.marginBottom = 15.0,
    this.contentPadding = const EdgeInsets.only(
      top: 10.0,
      bottom: 10.0,
      left: 13.0,
      right: 13.0,
    ),
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final double marginBottom;
  final EdgeInsetsGeometry contentPadding;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        validator: validator,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(color: Colors.black),
        obscureText: obscureText,
        decoration: InputDecoration(
          counterStyle: const TextStyle(height: double.minPositive),
          counterText: '',
          errorMaxLines: 2,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium!.copyWith(
            color: AppColors.kHintColor,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
