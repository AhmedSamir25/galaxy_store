import 'package:fashionstown/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'features/auth/presentation/view/sign_in_view.dart';

void main() {
  runApp(const Fashionstown());
}

class Fashionstown extends StatelessWidget {
  const Fashionstown({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashions Town',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:appColor),
        useMaterial3: true,
      ),
      home: const SignInView(),
    );
  }
}