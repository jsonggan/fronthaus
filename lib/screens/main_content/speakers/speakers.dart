import 'package:flutter/material.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:fronthaus/screens/main_content/speakers/components/body.dart';
import 'package:fronthaus/screens/sign_in/components/body.dart';
import 'package:fronthaus/widgets/custom_appbar.dart';

class SpeakersPage extends StatelessWidget {
  static String routeName = '/speaker_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(),
      body: Container(
        child: Speakers(),
      ),
    );
  }
}
