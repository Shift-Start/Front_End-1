import 'package:ShiftStart/Dashboard/recommendationManagement.dart';
import 'package:flutter/material.dart';

import 'activityLogPage.dart';
import 'dashBoardOverviewScreen.dart';
import 'notificationsPage.dart';
import 'reportsAnalytics.dart';
import 'settingsPage.dart';
import 'taskManagement.dart';
import 'teamManagement.dart';
import 'templateManagement.dart';
import 'usersManagement.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Widget _selectedPage = DashboardOverview(); // الصفحة الافتراضية

  // قائمة الصفحات في Bottom Navigation Bar
  final List<Widget> _bottomNavPages = [
    DashboardOverview(),
    UsersManagement(),
    TeamManagement(),
    TaskManagement(),
    TemplateManagement(),
  ];

  // عند الضغط على Bottom Navigation Bar
  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = _bottomNavPages[index];
    });
  }

  // عند الضغط على أي عنصر في Drawer
  void _onDrawerItemTapped(Widget page) {
    setState(() {
      _selectedPage = page;
      Navigator.pop(context); // إغلاق الـ Drawer بعد الاختيار
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Management System")),

      // 🔹 Drawer Menu
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("john.doe@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/avatar3.jpeg"),
              ),
            ),
            _buildDrawerItem(Icons.recommend, "Recommendations",
                RecommendationsManagement()),
            Divider(),
            _buildDrawerItem(
                Icons.analytics, "Reports & Analytics", ReportsAndAnalytics()),
            Divider(),
            _buildDrawerItem(Icons.notifications, "Notifications",
                NotificationManagementPage()),
            Divider(),
            _buildDrawerItem(Icons.history, "Activity Log", ActivityLogPage()),
            Divider(),
            _buildDrawerItem(Icons.settings, "Settings", SystemSettings()),
            Divider(),
            SizedBox(
              height: 150,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // تنفيذ تسجيل الخروج
              },
            ),
          ],
        ),
      ),

      // 🔹 محتوى الصفحة يتغير بناءً على الاختيار
      body: _selectedPage,

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: Colors.blue, // اللون عند التحديد
        unselectedItemColor: Colors.grey, // اللون عند عدم التحديد
        showUnselectedLabels: true, // عرض النص حتى لو لم يكن محددًا
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Teams",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: "Templates",
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لإنشاء عناصر Drawer مع تغيير لون الأيقونات عند التحديد
  Widget _buildDrawerItem(IconData icon, String title, Widget page) {
    bool isSelected = _selectedPage.runtimeType == page.runtimeType;

    return ListTile(
      leading: Icon(
        icon,
        color:
            isSelected ? Colors.blue : Colors.grey, // تغيير اللون عند التحديد
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              isSelected ? Colors.blue : Colors.black, // تغيير النص عند التحديد
          fontWeight: isSelected
              ? FontWeight.bold
              : FontWeight.normal, // جعل النص عريض عند التحديد
        ),
      ),
      onTap: () => _onDrawerItemTapped(page), // تحديث الصفحة عند الضغط
    );
  }
}
