import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/auth/multiplayer_login.dart';
import 'package:tic_tac/auth/signIn.dart';
import 'package:tic_tac/auth/signup.dart';
import 'package:tic_tac/auth/user_info.dart';
import 'package:tic_tac/screens/game__mode.dart';
import 'package:tic_tac/utils/theme_colors.dart';

import 'auth/sign_in_provider.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notification', //title
    description:
    "This channel is used for important notifications", //description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>ThemeProvider()),
        ChangeNotifierProvider(create: (context) =>GoogleSignInProvider()),
      ],
      builder: (context,_){
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: MyThemes.darkTheme,
          title: 'TicTacToe',
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          // themeMode: myTheme(),
          home: const GameMode(),
        );
      },
    );
  }
}

