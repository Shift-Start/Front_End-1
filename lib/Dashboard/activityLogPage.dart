import 'package:flutter/material.dart';

class ActivityLogPage extends StatefulWidget {
  @override
  _ActivityLogPageState createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  List<Map<String, dynamic>> activities = [
    {"type": "login", "user": "John Doe", "date": "2024-02-05 10:30 AM"},
    {"type": "logout", "user": "Jane Smith", "date": "2024-02-05 11:00 AM"},
    {"type": "edit", "user": "Admin", "date": "2024-02-05 11:15 AM"},
    {"type": "login", "user": "David Lee", "date": "2024-02-05 12:00 PM"},
    {"type": "edit", "user": "Sarah Connor", "date": "2024-02-05 01:45 PM"},
  ];

  String selectedFilter = "All";

  // 🔹 إرجاع الأيقونة المناسبة لكل نوع نشاط
  IconData getIcon(String type) {
    switch (type) {
      case "login":
        return Icons.login;
      case "logout":
        return Icons.logout;
      case "edit":
        return Icons.edit;
      default:
        return Icons.info;
    }
  }

  // 🔹 إرجاع اللون المناسب لكل نوع نشاط
  Color getColor(String type) {
    switch (type) {
      case "login":
        return Colors.green;
      case "logout":
        return Colors.red;
      case "edit":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredActivities = selectedFilter == "All"
        ? activities
        : activities.where((activity) => activity["type"] == selectedFilter.toLowerCase()).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Activity Log")),
      body: Column(
        children: [
          // 🔹 قائمة الفلاتر
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              items: ["All", "Login", "Logout", "Edit"].map((String category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                });
              },
            ),
          ),
          Divider(),

          // 🔹 عرض قائمة النشاطات
          Expanded(
            child: ListView.builder(
              itemCount: filteredActivities.length,
              itemBuilder: (context, index) {
                final activity = filteredActivities[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(getIcon(activity["type"]), color: getColor(activity["type"]), size: 30),
                    title: Text(
                      "${activity["user"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${activity["date"]}"),
                    trailing: Text(
                      activity["type"].toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getColor(activity["type"]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
     ),
);
}
}
