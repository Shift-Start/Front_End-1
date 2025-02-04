import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  //  Light Theme Colors

  static const Color lightBackground =
      Color(0xFFF0F4F8); // خلفية فاتحة (تقريبًا أبيض بلمسة زرقاء)
  static const Color lightPrimaryText = Color(0xFF3B7197); // أزرق داكن
  static const Color lightSecondaryText = Color(0xFF4A8DB7); // أزرق فاتح
  static const Color lightButton = Color(0xFF74BDE0); // أزرق سماوي فاتح
  static const Color lightCard = Color(0xFFFFFFFF); // أبيض نقي

// Dark Theme Colors
  static const Color darkBackground = Color(0xFF2C3E50); // رمادي داكن
  static const Color darkPrimaryText = Color(0xFFFFFFFF); // أبيض فاتح
  static const Color darkSecondaryText = Color(0xFF74BDE0); // أزرق سماوي فاتح
  static const Color darkButton = Color(0xFF4A8DB7); // أزرق فاتح
  static const Color darkCard = Color(0xFF34495E); // رمادي داكن
}

class UiProviderAdmain extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  late SharedPreferences storage;

  // Light Theme
  ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightButton,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: AppColors.lightPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'DMSans_18pt-Bold',
      ),
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.lightButton,
    cardColor: AppColors.lightCard,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.lightPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.lightPrimaryText,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: AppColors.lightSecondaryText,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[600]),
      labelStyle: TextStyle(color: AppColors.lightPrimaryText),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightButton),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightButton, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.lightPrimaryText),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.lightButton,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  // Dark Theme
  ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkButton,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: AppColors.darkPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'DMSans_18pt-Bold',
      ),
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkButton,
    cardColor: AppColors.darkCard,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkPrimaryText,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: AppColors.darkSecondaryText,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      labelStyle: TextStyle(color: AppColors.darkPrimaryText),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkButton),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkButton, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.darkPrimaryText),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.darkButton,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  // Dark mode toggle action
  void changeTheme() async {
    _isDark = !_isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  // Initialize provider
  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}
