import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:fronthaus/screens/main_home/main_home.dart';

import 'package:fronthaus/screens/sign_in/sign_in.dart';
import 'package:fronthaus/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'dart:async';

SharedPreferences? sharedPrefs;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  // for shared preference and FCM
  WidgetsFlutterBinding.ensureInitialized();

  //shared preference initialize
  sharedPrefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //for IOS to request permission for notification
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  //for ios to display notification while app is in foreground
  if (Platform.isIOS) {
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');
    // print('Message data: ${message.category}');
    // print('Message data: ${message.collapseKey}');

    // print('Message data: ${message.contentAvailable}');
    // print('Message data: ${message.from}');
    // print('Message data: ${message.messageId}');
    // print('Message data: ${message.messageType}');
    // print('Message data: ${message.mutableContent}');

    // print('Message data: ${message.notification}');
    // print('Message data: ${message.senderId}');
    // print('Message data: ${message.sentTime}');
    // print('Message data: ${message.threadId}');
    // print('Message data: ${message.ttl}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await messaging.subscribeToTopic('testing');

  print('User granted permission: ${settings.authorizationStatus}');
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
            initialRoute: MainHomePage.routeName,
            routes: routes,
          ),
        );
      }),
    );
  }
}
