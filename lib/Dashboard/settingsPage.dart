import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShiftStart/Dashboard/themeColor.dart';


class SystemSettings extends StatefulWidget {
  @override
  _SystemSettingsState createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  int maxTeams = 5;
  int maxTasks = 20;
  List<String> userRoles = ["Admin", "Editor", "Viewer"];
  String selectedRole = "Viewer";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProviderAdmain>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("System Settings"),
        backgroundColor: themeProvider.isDark ? Colors.black : AppColors.lightButton,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //  تبديل الثيم
          _buildSettingTile(
            title: "Dark Mode",
            subtitle: "Switch between light and dark themes",
            icon: Icons.brightness_6,
            color: Colors.blue,
            trailing: Switch(
              value: themeProvider.isDark,
              onChanged: (value) => themeProvider.changeTheme(),
            ),
          ),

          //  إعداد صلاحيات المستخدمين
          _buildSettingTile(
            title: "User Role",
            subtitle: "Current Role: $selectedRole",
            icon: Icons.admin_panel_settings,
            color: Colors.orange,
            trailing: DropdownButton<String>(
              value: selectedRole,
              items: userRoles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
          ),

          //  الحد الأقصى للفرق
          _buildEditableSetting(
            title: "Max Teams per User",
            subtitle: "$maxTeams teams allowed",
            icon: Icons.group,
            color: Colors.green,
            value: maxTeams,
            onEdit: (newValue) {
              setState(() {
                maxTeams = newValue;
              });
            },
          ),

          //  الحد الأقصى للمهام
          _buildEditableSetting(
            title: "Max Tasks per User",
            subtitle: "$maxTasks tasks allowed",
            icon: Icons.task,
            color: Colors.purple,
            value: maxTasks,
            onEdit: (newValue) {
              setState(() {
                maxTasks = newValue;
              });
            },
          ),

          //  إدارة كلمات المرور
          _buildSettingTile(
            title: "Manage Passwords",
            subtitle: "Change or reset passwords",
            icon: Icons.lock,
            color: Colors.red,
            onTap: _showPasswordManagementDialog,
          ),

          //  سجل المحاولات الفاشلة
          _buildSettingTile(
            title: "Failed Login Attempts Log",
            subtitle: "View login security logs",
            icon: Icons.security,
            color: Colors.brown,
            onTap: _showFailedLoginAttemptsDialog,
          ),
        ],
      ),
    );
  }

  //  دالة لإنشاء عناصر الإعدادات القابلة للتعديل
  Widget _buildEditableSetting({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int value,
    required Function(int) onEdit,
  }) {
    return _buildSettingTile(
      title: title,
      subtitle: subtitle,
      icon: icon,
      color: color,
      trailing: IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          _editLimit(title, value, onEdit);
        },
      ),
    );
  }

  //  دالة لإنشاء عناصر الإعدادات
  Widget _buildSettingTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: trailing,
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }

  //  تعديل الحد الأقصى للفرق أو المهام
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
            decoration: const InputDecoration(labelText: "Enter new limit"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
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

  //  نافذة إدارة كلمات المرور
  void _showPasswordManagementDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Password Management"),
          content: const Text("Feature coming soon!"),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  //  نافذة سجل المحاولات الفاشلة
  void _showFailedLoginAttemptsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Failed Login Attempts"),
          content: const Text("No failed attempts recorded."),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
     },
);
}
}
