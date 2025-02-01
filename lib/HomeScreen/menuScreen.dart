import 'package:ShiftStart/BottomNavBar/bottomNavBar.dart';
import 'package:ShiftStart/Profile/recommendation.dart';
import 'package:flutter/material.dart';

import '../Habits/habitTemplete.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Profile/competitors.dart';

import '../Profile/logout.dart';
import '../Profile/profile.dart';
import '../Profile/puzzle.dart';

import '../Profile/setting.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // الحصول على الثيم الحالي
    final textTheme = theme.textTheme; // الحصول على نصوص الثيم
    final colorScheme = theme.colorScheme; // الحصول على ألوان الثيم

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Bottomnavbar(
                      selectedModel: '',
                    )));
          },
          icon: Icon(Icons.arrow_back,
              color: colorScheme.onPrimary), // لون الأيقونة يتغير مع الثيم
        ),
        backgroundColor: colorScheme.primary, // لون الخلفية من الثيم
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // صورة المستخدم
                CircleAvatar(
                  radius: 40,
                  backgroundColor: colorScheme.surface, // لون الخلفية من الثيم
                  child: Icon(Icons.person,
                      size: 50,
                      color: colorScheme.onSurface), // أيقونة بلون الثيم
                ),
                SizedBox(height: 1),
                // عناصر القائمة
                _buildMenuItem(
                  context,
                  Icons.person,
                  "Profile",
                  textTheme.bodyLarge!.color ??
                      Colors.black, // لون النص من الثيم
                  Profile(),
                ),
                Divider(color: colorScheme.outline), // لون الفاصل من الثيم
                _buildMenuItem(
                  context,
                  Icons.recommend,
                  "Recommendation",
                  textTheme.bodyLarge!.color ?? Colors.black,
                  RecommendationScreen(),
                ),
                Divider(color: colorScheme.outline),
                _buildMenuItem(
                  context,
                  Icons.extension,
                  "Puzzle",
                  textTheme.bodyLarge!.color ?? Colors.black,
                  Puzzle(),
                ),
                Divider(color: colorScheme.outline),
                _buildMenuItem(
                  context,
                  Icons.group,
                  "Competitors",
                  textTheme.bodyLarge!.color ?? Colors.black,
                  Competitors(),
                ),
                Divider(color: colorScheme.outline),
                _buildMenuItem(
                  context,
                  Icons.check_circle,
                  "Habits",
                  textTheme.bodyLarge!.color ?? Colors.black,
                  HabitsTemplateScreen(),
                ),
                Divider(color: colorScheme.outline),
                _buildMenuItem(
                  context,
                  Icons.settings,
                  "Setting",
                  textTheme.bodyLarge!.color ?? Colors.black,
                  SettingsScreen(
                    onThemeChange: (ThemeMode) {},
                  ),
                ),
                Divider(color: colorScheme.outline),
                _buildMenuItem(
                  context,
                  Icons.logout,
                  "Logout",
                  Colors.red,
                  Logout(),
                ),
                Divider(color: colorScheme.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text,
      Color textColor, Widget destinationPage) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          text,
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: textColor), // نمط النص من الثيم
        ),
        contentPadding: EdgeInsets.zero,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
      ),
    );
  }
}
