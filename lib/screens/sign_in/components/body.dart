import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:fronthaus/providers/auth_provider.dart';
import 'package:fronthaus/screens/verification_code/verification_code.dart';
import 'package:fronthaus/widgets/custom_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fronthaus/widgets/snack_bar.dart';
import 'package:fronthaus/widgets/text_input_field.dart';

class SignInEmail extends StatefulWidget {
  const SignInEmail({Key? key}) : super(key: key);

  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool _isPress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 8),
              Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width / 2.0,
                      child: Image.asset('assets/images/fronthaus_logo.png'))),
              const Spacer(flex: 4),
              TextInputField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
                type: 'Email',
                controller: emailController,
              ),
              const Spacer(flex: 1),
              CustomButton(
                text: "Next",
                press: !_isPress
                    ? () {
                        setState(() {
                          _isPress = true;
                        });
                        Timer(Duration(seconds: 1), () {
                          setState(() {
                            _isPress = false;
                          });
                        });
                        next();
                      }
                    : null,
              ),
              const Spacer(
                flex: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> next() async {
    final isValidForm = _formKey.currentState!.validate();
    if (isValidForm) {
      CustomSnackBar.showLoading(context);

      final AuthProvider provider =
          Provider.of<AuthProvider>(context, listen: false);

      await provider.loginStep1(emailController.text);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      CustomSnackBar.showMessage(
          context, Provider.of<AuthProvider>(context, listen: false).msgLogin1);

      provider.msgLogin1 == 'Your 2FA has been sent to your email address.'
          ? Navigator.pushReplacementNamed(
              context, VerificationCodePage.routeName)
          : Provider.of<AuthProvider>(context, listen: false).msgLogin1 =
              Provider.of<AuthProvider>(context, listen: false)
                  .mapSignin1['message'];
    }
  }
}
