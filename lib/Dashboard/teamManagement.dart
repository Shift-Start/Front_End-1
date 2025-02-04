import 'package:flutter/material.dart';


import 'themeColor.dart'; 

class TeamManagement extends StatefulWidget {
  const TeamManagement({super.key});

  @override
  _TeamManagementState createState() => _TeamManagementState();
}

class _TeamManagementState extends State<TeamManagement> {
  // قائمة الفرق
  List<Map<String, dynamic>> teams = [
    {"name": "Team A", "members": 10},
    {"name": "Team B", "members": 5},
    {"name": "Team C", "members": 8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Management"),
        backgroundColor: AppColors.lightButton, // تغيير اللون حسب الثيم
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شريط البحث
            const TextField(
              decoration: InputDecoration(
                labelText: "Search for a team...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: AppColors.lightCard, // تغيير لون البطاقة
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.group),
                      ),
                      title: Text(
                        team["name"],
                        style: TextStyle(
                          color: AppColors.lightPrimaryText, // تغيير اللون للنص
                        ),
                      ),
                      subtitle: Text(
                        "Members: ${team["members"]}",
                        style: TextStyle(
                          color: AppColors.lightPrimaryText, // تغيير اللون للنص
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // يمكنك إضافة المزيد من الأزرار هنا مثل تعديل أو حذف الفريق
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // زر إضافة فريق جديد
            ElevatedButton.icon(
              onPressed: () {
                // هنا يمكنك إضافة وظيفة إضافة فريق جديد
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Team"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton, // تغيير لون الزر
              ),
            ),
          ],
        ),
     ),
);
}
}
