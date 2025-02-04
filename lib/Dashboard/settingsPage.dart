import 'package:ShiftStart/Dashboard/themeColor.dart';
import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemSettings extends StatefulWidget {
  @override
  _SystemSettingsState createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  bool isDarkMode = false; // للتحكم في الثيم
  int maxTeams = 5;
  int maxTasks = 20;
  List<String> userRoles = ["Admin", "Editor", "Viewer"];
  String selectedRole = "Viewer";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProviderAdmain>(context);
    return Scaffold(
      appBar: AppBar(title: Text("System Settings")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 تبديل الثيم
            ListTile(
              leading: Icon(Icons.brightness_6, color: Colors.blue),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: themeProvider.isDark,
                onChanged: (value) {
                  setState(() {
                    themeProvider.changeTheme();
                  });
                },
              ),
            ),
            Divider(),

            // 🔹 إعداد صلاحيات المستخدمين
            ListTile(
              leading: Icon(Icons.admin_panel_settings, color: Colors.orange),
              title: Text("User Role"),
              subtitle: Text("Current Role: $selectedRole"),
              trailing: DropdownButton<String>(
                value: selectedRole,
                items: userRoles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
            ),
            Divider(),

            // 🔹 الحد الأقصى للفرق
            ListTile(
              leading: Icon(Icons.group, color: Colors.green),
              title: Text("Max Teams per User"),
              subtitle: Text("$maxTeams teams allowed"),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  _editLimit("Max Teams", maxTeams, (value) {
                    setState(() {
                      maxTeams = value;
                    });
                  });
                },
              ),
            ),
            Divider(),

            // 🔹 الحد الأقصى للمهام
            ListTile(
              leading: Icon(Icons.task, color: Colors.purple),
              title: Text("Max Tasks per User"),
              subtitle: Text("$maxTasks tasks allowed"),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  _editLimit("Max Tasks", maxTasks, (value) {
                    setState(() {
                      maxTasks = value;
                    });
                  });
                },
              ),
            ),
            Divider(),

            // 🔹 إدارة كلمات المرور
            ListTile(
              leading: Icon(Icons.lock, color: Colors.red),
              title: Text("Manage Passwords"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showPasswordManagementDialog();
              },
            ),
            Divider(),

            // 🔹 سجل المحاولات الفاشلة
            ListTile(
              leading: Icon(Icons.security, color: Colors.brown),
              title: Text("Failed Login Attempts Log"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showFailedLoginAttemptsDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 تعديل الحد الأقصى للفرق أو المهام
  void _editLimit(String title, int currentValue, Function(int) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter new limit"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                int newValue = int.tryParse(controller.text) ?? currentValue;
                onSave(newValue);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // 🔹 نافذة إدارة كلمات المرور
  void _showPasswordManagementDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Password Management"),
          content: Text("Feature coming soon!"),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  // 🔹 نافذة سجل المحاولات الفاشلة
  void _showFailedLoginAttemptsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Failed Login Attempts"),
          content: Text("No failed attempts recorded."),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
