// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/colors.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UiProvider extends ChangeNotifier {
//   bool _isDark = false;
//   bool get isDark => _isDark;
//   late SharedPreferences storage;

//   final darkTheme = ThemeData(
//       primaryColor: Color.fromARGB(31, 250, 30, 30),
//       brightness: Brightness.dark,
//       // primaryColorDark: const Color.fromARGB(31, 122, 47, 47),
//       // scaffoldBackgroundColor: darkprimaryColor,
//       // appBarTheme: AppBarTheme(backgroundColor: darkprimaryColor2),
//       // textTheme: TextTheme(bodyMedium: TextStyle(color: darkwhiteColor)),
//       // bottomAppBarTheme: BottomAppBarTheme(color: darkprimaryColor2),
//       // primaryColorDark: darkprimaryColor2,
//       // primaryColor: darkprimaryColor2
//        );

//   final lightTheme = ThemeData(
//       primaryColor: Colors.white,
//       brightness: Brightness.light,
//       primaryColorDark: Colors.white,
//       );
//   //dark mode toggle action
//   changeTheme() {
//     _isDark = !isDark;
//     storage.setBool('isDark', _isDark);
//     notifyListeners();
//   }

// //init method of provider
//   init() async {
//     storage = await SharedPreferences.getInstance();
//     _isDark = storage.getBool('isDark') ?? false;
//     notifyListeners();
//   }
// }
