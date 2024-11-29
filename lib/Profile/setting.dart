import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomeScreen/menuScreen.dart';
import '../colors.dart';

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChange;

  SettingsScreen({required this.onThemeChange});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // الوصول إلى ThemeData الحالية
    return Scaffold(
      appBar: AppBar(titleTextStyle:
            TextStyle(color: AppColors.lightPrimaryText, fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'DMSans_18pt-Bold'),
        backgroundColor: theme.primaryColor, // استخدام اللون الأساسي من الثيم
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MenuScreen()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Settings",
       
             // theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.menu,
        //       size: 29,
        //       color: theme.textTheme.bodyLarge?.color,
        //     ),
        //     onPressed: () {
        //       // يمكن هنا إضافة أكشن عند الضغط على الأيقونة
        //     },
        //   ),
        // ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Personal Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Personal Settings",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // action for edit personal settings
                },
                child: Text("Edit", style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.person, color: theme.primaryColor),
            subtitle: TextField(
              decoration: InputDecoration(
                hintText: 'Florencla Yannuzzi',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email, color: theme.primaryColor),
            subtitle: TextField(
              decoration: InputDecoration(
                hintText: 'florenciayannuzzi@gmail.com',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 5),
          // Classes Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Classes Settings",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // action for adding class
                },
                child: Text(
                  "+class",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          // Example classes
          _buildClassTile(
              context, "EC 202 - Principles Microeconomics", Colors.purple),
          _buildClassTile(
              context, "EC 203 - Principles Macroeconomics", Colors.teal),
          _buildClassTile(
              context, "FN 215 - Financial Management", Colors.blue),
          _buildClassTile(
              context, "MGT 101 - Organization Management", Colors.orange),
          SizedBox(height: 8),
          // App Settings
          Text(
            "App Settings",
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Divider(),
          Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
              return SwitchListTile(
                value: notifier.isDark,
                onChanged: (value) => notifier.changeTheme(),
                title: Text("Dark mode", style: theme.textTheme.bodyLarge),
              );
            },
          ),
          ListTile(
            title: Text("Privacy policy", style: theme.textTheme.bodyMedium),
            onTap: () {
              // action for privacy policy
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClassTile(BuildContext context, String title, Color color) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        height: 28,
        child: VerticalDivider(thickness: 3, color: color),
      ),
      title: Text(title, style: theme.textTheme.bodyLarge),
      trailing: TextButton(
        onPressed: () {
          // action for editing class
        },
        child: Text("Edit", style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
