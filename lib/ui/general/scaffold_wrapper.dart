import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(child: child),
      ),
    );
  }
}