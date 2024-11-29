// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightBackground = Color.fromARGB(255, 245, 232, 234);
  static const Color lightPrimaryText = Color(0xFF19305C);
  static const Color lightSecondaryText = Color(0xFFAE7DAC);
  static const Color lightButton = Color(0xFFF1916D);
  static const Color lightCard = Color.fromARGB(255, 62, 60, 110);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF03122F);
  static const Color darkPrimaryText = Color(0xFFF3DADF);
  static const Color darkSecondaryText = Color(0xFFAE7DAC);
  static const Color darkButton = Color(0xFFF1916D);
  static const Color darkCard = Color(0xFF413B61);
}

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  late SharedPreferences storage;

  // Dark Theme
// Light Theme
  ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightButton,
        elevation: 4,
        titleTextStyle: TextStyle(
            color: AppColors.lightPrimaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans_18pt-Bold')),
    scaffoldBackgroundColor: AppColors.lightBackground, // خلفية الشاشة
    primaryColor: AppColors.lightButton, // اللون الأساسي
    cardColor: AppColors.lightCard, // لون الكروت

    textTheme: TextTheme(
      bodyLarge: TextStyle(
          color: AppColors.lightPrimaryText, fontSize: 16), // النصوص الأساسية
      bodyMedium: TextStyle(
          color: AppColors.lightSecondaryText, fontSize: 14), // النصوص الثانوية
    ),
    inputDecorationTheme:
        InputDecorationTheme(hintStyle: TextStyle(color: Colors.black)),
    iconTheme: IconThemeData(color: AppColors.lightPrimaryText),
    colorScheme: ColorScheme.light(onPrimary: Colors.white),

    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.lightButton, // لون الأزرار
      textTheme: ButtonTextTheme.primary,
      // لون النص داخل الزر
    ),
  );

  // Light Theme
// Dark Theme
  ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkButton,
        elevation: 4,
        titleTextStyle: TextStyle(
            color: AppColors.darkPrimaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans_18pt-Bold')),

    scaffoldBackgroundColor: AppColors.darkBackground, // خلفية الشاشة
    primaryColor: AppColors.darkButton, // اللون الأساسي
    cardColor: AppColors.darkCard, // لون الكروت
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: Color.fromARGB(255, 239, 232, 235),
            fontSize: 18), // النصوص الأساسية
        bodyMedium: TextStyle(
            color: const Color.fromARGB(255, 237, 231, 237), fontSize: 16),
        bodySmall: TextStyle(
            color: const Color.fromARGB(255, 237, 231, 237),
            fontSize: 14) // النصوص الثانوية
        ),
    inputDecorationTheme:
        InputDecorationTheme(hintStyle: TextStyle(color: Colors.white)),
    iconTheme: IconThemeData(color: AppColors.darkPrimaryText),

    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.darkButton, // لون الأزرار
      textTheme: ButtonTextTheme.primary, // لون النص داخل الزر
    ),
  );
//dark mode toggle action
  changeTheme() {
    _isDark = !isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

//init method of provider
  init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}
