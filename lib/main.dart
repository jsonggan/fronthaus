import 'package:flutter/material.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:fronthaus/providers/agenda_provider.dart';
import 'package:fronthaus/providers/auth_provider.dart';
import 'package:fronthaus/providers/event_provider.dart';
import 'package:fronthaus/providers/map_provider.dart';
import 'package:fronthaus/providers/select_dropdown/select_event_name.dart';
import 'package:fronthaus/providers/select_dropdown/select_profession.dart';
import 'package:fronthaus/providers/sessions_provider.dart';
import 'package:fronthaus/providers/speakers_provider.dart';
import 'package:fronthaus/providers/sponsors_provider.dart';
import 'package:fronthaus/providers/user_provider.dart';
import 'package:fronthaus/providers/world_time_provider.dart';
import 'package:fronthaus/screens/sign_in/sign_in.dart';
import 'package:fronthaus/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(const MyApp());

SharedPreferences? sharedPrefs;

Future<void> main() async {
  // make it async

  WidgetsFlutterBinding.ensureInitialized(); // mandatory when awaiting on main

  sharedPrefs = await SharedPreferences.getInstance(); // get the prefs
  // // do whatever you need to do with it

  runApp(MyApp()); // rest of your app code
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AgendaProvider>(
              create: (context) => AgendaProvider(authProvider),
            ),
            ChangeNotifierProvider<EventProvider>(
              create: (context) => EventProvider(authProvider),
            ),
            ChangeNotifierProvider<SelectEventName>(
              create: (context) => SelectEventName(),
            ),
            ChangeNotifierProvider<MapProvider>(
              create: (context) => MapProvider(authProvider),
            ),
            ChangeNotifierProvider<SponsorsProvider>(
              create: (context) => SponsorsProvider(authProvider),
            ),
            ChangeNotifierProvider<SpeakersProvider>(
              create: (context) => SpeakersProvider(authProvider),
            ),
            ChangeNotifierProvider<SessionsProvider>(
              create: (context) => SessionsProvider(authProvider),
            ),
            ChangeNotifierProvider<SelectProfession>(
              create: (context) => SelectProfession(),
            ),
            ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider(authProvider),
            ),
            ChangeNotifierProvider<WorldTimeProvider>(
              create: (context) => WorldTimeProvider(authProvider),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                titleLarge: titleTextStyle,
                titleMedium: countdownTextStyle,
                bodySmall: body2TextStyle,
                bodyMedium: tagTextStyle,
                bodyLarge: body1TextStyle,
              ),
              scaffoldBackgroundColor: backGroundColor,
            ),
            home: SignInPage(),
            initialRoute: SignInPage.routeName,
            routes: routes,
          ),
        );
      }),
    );
  }
}
