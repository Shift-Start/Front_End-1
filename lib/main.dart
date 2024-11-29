import 'package:ShiftStart/LogIn/signUp.dart';
import 'package:ShiftStart/LogIn/successfully.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'BottomNavBar/bottomNavBar.dart';
import 'Habits/habitTemplete.dart';
import 'HomeScreen/Assignments.dart';
import 'HomeScreen/HomeScreen.dart';
import 'HomeScreen/calander.dart';
import 'HomeScreen/menuScreen.dart';
import 'HomeScreen/newAssignment.dart';
import 'HomeScreen/schedule.dart';
import 'LogIn/check your email.dart';
import 'LogIn/forgetPassword.dart';
import 'LogIn/login.dart';
import 'Profile/profile.dart';
import 'Profile/setting.dart';
import 'SplashScreen/splashScreen.dart';
import 'Templets/templet.dart';
import 'colors.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => UiProvider()..init(),
        child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            home: Splashscreen(),
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:
                notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
            theme: ThemeData(),

            debugShowCheckedModeBanner: false,
            // home:SettingsScreen()
          );
        }));
    //: SettingsScreen(onThemeChange: (mode) {
    //   setState(() {
    //     _themeMode = mode;
    //   });
    // }));
  }
}
