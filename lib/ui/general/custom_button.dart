import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onPressed, bool? isLoading, required this.text})
      : isLoading = isLoading ?? false;

  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.4,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Center(child: Text(text)),
        ),
      ),
    );
  }
}
