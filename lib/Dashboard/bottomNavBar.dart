import 'package:flutter/material.dart';
import 'package:ShiftStart/Dashboard/recommendationManagement.dart';
import 'activityLogPage.dart';
import 'dashBoardOverviewScreen.dart';
import 'notificationsPage.dart';
import 'reportsAnalytics.dart';
import 'settingsPage.dart';
import 'taskManagement.dart';
import 'teamManagement.dart';
import 'templateManagement.dart';
import 'themeColor.dart';
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
      appBar: AppBar(
        title: Text(
          "Management System",
          style: TextStyle(color: AppColors.lightPrimaryText), // تغيير اللون حسب الثيم
        ),
        backgroundColor: AppColors.lightButton, // اللون الأساسي للـ AppBar
      ),

      //  Drawer Menu
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "John Doe",
                style: TextStyle(color: AppColors.lightPrimaryText),
              ),
              accountEmail: Text(
                "john.doe@example.com",
                style: TextStyle(color: AppColors.lightSecondaryText),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/avatar3.jpeg"),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
              ),
            ),
            _buildDrawerItem(Icons.recommend, "Recommendations", RecommendationsManagement()),
            Divider(),
            _buildDrawerItem(Icons.analytics, "Reports & Analytics", ReportsAndAnalytics()),
            Divider(),
            _buildDrawerItem(Icons.notifications, "Notifications", NotificationManagementPage()),
            Divider(),
            _buildDrawerItem(Icons.history, "Activity Log", ActivityLogPage()),
            Divider(),
            _buildDrawerItem(Icons.settings, "Settings", SystemSettings()),
            Divider(),
            SizedBox(height: 150),
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
        selectedItemColor: AppColors.lightButton, // اللون عند التحديد
        unselectedItemColor: AppColors.lightSecondaryText, // اللون عند عدم التحديد
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
            isSelected ? AppColors.lightButton : AppColors.lightPrimaryText, // تغيير اللون عند التحديد
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              isSelected ? AppColors.lightButton : AppColors.lightPrimaryText, // تغيير النص عند التحديد
          fontWeight: isSelected
              ? FontWeight.bold
              : FontWeight.normal, // جعل النص عريض عند التحديد
        ),
      ),
      onTap: () => _onDrawerItemTapped(page), // تحديث الصفحة عند الضغط
);
}
}
