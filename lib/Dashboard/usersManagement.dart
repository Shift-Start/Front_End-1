import 'package:flutter/material.dart';

class UsersManagement extends StatefulWidget {
  const UsersManagement({super.key});

  @override
  _UsersManagementState createState() => _UsersManagementState();
}

class _UsersManagementState extends State<UsersManagement> {
  // قائمة المستخدمين مع تاريخ التسجيل
  List<Map<String, dynamic>> users = [
    {
      "name": "Ahmed Mohamed",
      "email": "ahmed@example.com",
      "status": "Active",
      "tasks": 12,
      "loginDate": DateTime.now()
    },
    {
      "name": "Sara Khaled",
      "email": "sara@example.com",
      "status": "Inactive",
      "tasks": 5,
      "loginDate": DateTime.now()
    },
    {
      "name": "Mohammed Ali",
      "email": "mohammed@example.com",
      "status": "Active",
      "tasks": 8,
      "loginDate": DateTime.now()
    },
  ];

  String? filterStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Management")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شريط البحث
            const TextField(
              decoration: InputDecoration(
                labelText: "Search for a user...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // فلترة الحالة
            DropdownButton<String>(
              hint: const Text("Filter by Status"),
              value: filterStatus,
              onChanged: (String? newValue) {
                setState(() {
                  filterStatus = newValue;
                });
              },
              items: ["Active", "Inactive"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // عرض قائمة المستخدمين
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (filterStatus != null && user["status"] != filterStatus) {
                    return Container();
                  }
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(user["name"]),
                      subtitle: Text(user["email"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // زر تفعيل/تعطيل المستخدم
                          IconButton(
                            icon: Icon(
                              user["status"] == "Active"
                                  ? Icons.block
                                  : Icons.check_circle,
                              color: user["status"] == "Active"
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                user["status"] = user["status"] == "Active"
                                    ? "Inactive"
                                    : "Active";
                              });
                            },
                          ),
                          // زر حذف المستخدم
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                users.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _showUserDetails(context, user);
                      },
                    ),
                  );
                },
              ),
            ),

            // زر إضافة مستخدم جديد
            ElevatedButton.icon(
              onPressed: () {
                _showAddUserDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New User"),
            ),
          ],
        ),
      ),
    );
  }

  // عرض تفاصيل المستخدم
  void _showUserDetails(BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("User Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: ${user["name"]}"),
              Text("Email: ${user["email"]}"),
              Text("Status: ${user["status"]}"),
              Text("Tasks: ${user["tasks"]}"),
              Text("Login Date: ${user["loginDate"]}"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // إضافة مستخدم جديد
  void _showAddUserDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  users.add({
                    "name": nameController.text,
                    "email": emailController.text,
                    "status": "Active",
                    "tasks": 0,
                    "loginDate": DateTime.now(), // تسجيل تاريخ الدخول
                  });
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
