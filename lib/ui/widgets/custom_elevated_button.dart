import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.width,
    this.horizontalPadding = 10.0,
    this.verticalPadding = 10.0,
    this.fontSize,
    this.isLoading = false,
  });

  final String title;
  final double horizontalPadding;
  final double verticalPadding;
  final bool isLoading;
  final double? fontSize;
  final double? width;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null && !isLoading ? () => onPressed!() : null,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
