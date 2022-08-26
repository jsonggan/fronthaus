import 'package:flutter/material.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:fronthaus/screens/verification_code/components/body.dart';
import 'package:fronthaus/widgets/custom_appbar.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({Key? key}) : super(key: key);
  static String routeName = '/verification_code';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomTopAppBarWhiteIcon(),
      body: VerificationCode(),
    );
  }
}
