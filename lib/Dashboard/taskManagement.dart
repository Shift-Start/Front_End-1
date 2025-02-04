import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // مكتبة لتنسيق التاريخ


import 'themeColor.dart'; 

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  _TaskManagementState createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  List<Map<String, dynamic>> tasks = [
    {"name": "Design User Interface", "status": "Active", "createdAt": "2025-02-01"},
    {"name": "Review Financial Reports", "status": "Completed", "createdAt": "2025-01-15"},
    {"name": "Fix Bugs", "status": "Delayed", "createdAt": "2025-01-30"},
  ];

  String _statusFilter = "All";

  // ترشيح المهام بناءً على الحالة المختارة
  List<Map<String, dynamic>> getFilteredTasks() {
    if (_statusFilter == "All") {
      return tasks;
    }
    return tasks.where((task) => task["status"] == _statusFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        backgroundColor: AppColors.lightButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شريط الفلترة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter Tasks:"),
                DropdownButton<String>(
                  value: _statusFilter,
                  items: const [
                    DropdownMenuItem(value: "All", child: Text("All")),
                    DropdownMenuItem(value: "Active", child: Text("Active")),
                    DropdownMenuItem(value: "Completed", child: Text("Completed")),
                    DropdownMenuItem(value: "Delayed", child: Text("Delayed")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _statusFilter = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // قائمة المهام
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredTasks().length,
                itemBuilder: (context, index) {
                  final task = getFilteredTasks()[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: AppColors.lightCard,
                    child: ListTile(
                      title: Text(task["name"], style: TextStyle(color: AppColors.lightPrimaryText)),
                      subtitle: Text("Created At: ${task["createdAt"]}", style: const TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              task["status"] == "Active"
                                  ? Icons.check_circle
                                  : task["status"] == "Completed"
                                      ? Icons.done_all
                                      : Icons.cancel,
                              color: task["status"] == "Active"
                                  ? Colors.blue
                                  : task["status"] == "Completed"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                if (task["status"] == "Active") {
                                  task["status"] = "Completed";
                                } else if (task["status"] == "Completed") {
                                  task["status"] = "Delayed";
                                } else {
                                  task["status"] = "Active";
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                tasks.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // زر إضافة مهمة جديدة
            ElevatedButton.icon(
              onPressed: () => _showAddTaskDialog(context),
              icon: const Icon(Icons.add),
              label: const Text("Add New Task"),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightButton),
            ),
          ],
        ),
      ),
    );
  }

  // *وظيفة إضافة مهمة جديدة مع DatePicker*
  void _showAddTaskDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Task Name"),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Select Date:"),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text("Pick Date"),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  tasks.add({
                    "name": nameController.text,
                    "status": "Active",
                    "createdAt": selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                        : DateFormat('yyyy-MM-dd').format(DateTime.now()),
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
