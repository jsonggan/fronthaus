import 'package:flutter/material.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:fronthaus/screens/sign_in/components/body.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign_in_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColorBlack,
      body: Container(
        child: SignInEmail(),
      ),
    );
  }
}
