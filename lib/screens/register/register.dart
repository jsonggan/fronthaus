import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fronthaus/providers/auth_provider.dart';
import 'package:fronthaus/providers/select_dropdown/select_country.dart';
import 'package:fronthaus/providers/select_dropdown/select_gender.dart';
import 'package:fronthaus/providers/select_dropdown/select_picture.dart';
import 'package:fronthaus/providers/select_dropdown/select_salutation.dart';
import 'package:fronthaus/screens/register/components/body.dart';
import 'package:fronthaus/screens/register/components/body.dart';
import 'package:fronthaus/widgets/custom_appbar.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = '/register_profile';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SelectPicture(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectSalutation(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => SelectGender(),
        // ),
        ChangeNotifierProvider<SelectCountry>(
          create: (context) => SelectCountry(),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: CustomTopAppBar(),
          body: Container(
            child: Register(),
          ),
        );
      },
    );
  }
}
