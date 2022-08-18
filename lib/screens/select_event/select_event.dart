import 'package:flutter/material.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:fronthaus/widgets/custom_appbar.dart';
import 'components/body.dart';

class SelectEventPage extends StatelessWidget {
  static String routeName = '/select_event_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColorBlack,
      appBar: CustomTopAppBarWhiteIcon(),
      body: Container(
        child: SelectEvent(),
      ),
    );
  }
}
