import 'package:flutter/material.dart';
import '../HomeScreen/Assignments.dart';
import '../HomeScreen/HomeScreen.dart';
import '../HomeScreen/calander.dart';
import '../HomeScreen/schedule.dart';

class Bottomnavbar extends StatefulWidget {
  final String selectedModel;
  const Bottomnavbar({required this.selectedModel});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int currentIndex = 2;
  List screens = [
    Calendar(),
    SchedulePage(),
    Homescreen(),
    AssignmentsPage(),
    Scaffold()
  ];

  @override
  Widget build(BuildContext context) {
    // الحصول على الألوان من ThemeData بناءً على الوضع
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        shape: CircleBorder(),
        backgroundColor: theme.primaryColor, // استخدام اللون الأساسي
        child: Icon(
          Icons.add,
          color: theme.colorScheme.onPrimary, // اللون المناسب للأيقونة
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 58,
        color: theme.scaffoldBackgroundColor, // استخدام اللون الخلفي المناسب
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // أيقونة اليوم (Today)
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: _buildIcon(
                iconPath: 'icons/icons8-today-24.png',
                isSelected: currentIndex == 0,
              ),
            ),
            // أيقونة الأسبوع (Week)
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: _buildIcon(
                iconPath: 'icons/icons8-week-50.png',
                isSelected: currentIndex == 1,
              ),
            ),
            // أيقونة المهمات (Checklist)
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: _buildIcon(
                iconPath: 'icons/icons8-checklist-64.png',
                isSelected: currentIndex == 3,
              ),
            ),
            // أيقونة المستخدم (User)
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              icon: _buildIcon(
                iconPath: 'icons/icons8-employees-50.png',
                isSelected: currentIndex == 4,
                size: 28,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }

  // بناء الأيقونة مع التغيير في اللون حسب التحديد
  Widget _buildIcon(
      {required String iconPath, required bool isSelected, double size = 32}) {
    final theme = Theme.of(context);
    return Container(
      height: 45,
      width: 42,
      child: Image.asset(
        iconPath,
        color: isSelected
            ? theme.primaryColor // اللون الأساسي إذا كانت الأيقونة محددة
            : theme.iconTheme.color
                ?.withOpacity(0.6), // اللون الرمادي إذا لم تكن محددة
        height: size,
        width: size,
      ),
    );
  }
}
