import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'SplashScreen/splashScreen.dart';

import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ScreenUtilInit(designSize: Size(360, 690),builder: (context, child) => MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => UiProvider()..init(),
        child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;
          return MaterialApp(
            home: Splashscreen(),
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:
                notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
            theme: ThemeData(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
