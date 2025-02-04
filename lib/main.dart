import 'package:ShiftStart/CompetitorsBoard/leaderBoardScreen.dart';
import 'package:ShiftStart/Conversation/teamChatsScreen.dart';
import 'package:ShiftStart/Dashboard/themeColor.dart';
import 'package:ShiftStart/Dashboard/themeColor.dart';
import 'package:ShiftStart/Team/teamListScreen.dart';
import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'BottomNavBar/bottomNavBar.dart';
import 'CompetitorsBoard/leaderBoardProvider.dart';
import 'Conversation/chatProvider.dart';

import 'Dashboard/bottomNavBar.dart';
import 'Dashboard/dashBoardOverviewScreen.dart';
import 'Dashboard/themeColor.dart';
import 'Dashboard/themeColor.dart';
import 'Profile/recommendation.dart';
import 'SplashScreen/splashScreen.dart';

import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeamProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => UiProviderAdmain()..init()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProviderAdmain>(context);
    return ChangeNotifierProvider(
        create: (BuildContext context) => UiProvider()..init(),
        child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;
          return MaterialApp(
            home: HomeScreen(),
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:
                notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
           // theme: ThemeData(),
           theme: themeProvider.isDark ?themeProvider.darkTheme:themeProvider.lightTheme,
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
