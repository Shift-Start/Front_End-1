import 'package:flutter/material.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  _TaskManagementState createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  // Sample list of tasks (can be made dynamic later)
  List<Map<String, dynamic>> tasks = [
    {"name": "Design User Interface", "status": "Active", "createdAt": "2025-02-01"},
    {"name": "Review Financial Reports", "status": "Completed", "createdAt": "2025-01-15"},
    {"name": "Fix Bugs", "status": "Delayed", "createdAt": "2025-01-30"},
  ];

  // Filter variable for task status
  String _statusFilter = "All";

  // Function to filter tasks by status
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter Tasks:"),
                DropdownButton<String>(
                  value: _statusFilter,
                  items: const [
                    DropdownMenuItem(
                      value: "All",
                      child: Text("All"),
                    ),
                    DropdownMenuItem(
                      value: "Active",
                      child: Text("Active"),
                    ),
                    DropdownMenuItem(
                      value: "Completed",
                      child: Text("Completed"),
                    ),
                    DropdownMenuItem(
                      value: "Delayed",
                      child: Text("Delayed"),
                    ),
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

            // Task list
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredTasks().length,
                itemBuilder: (context, index) {
                  final task = getFilteredTasks()[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(task["name"]),
                      subtitle: Text("Created At: ${task["createdAt"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Change task status
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
                          // Delete task
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

            // Add New Task button
            ElevatedButton.icon(
              onPressed: () {
                _showAddTaskDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Task"),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the Add New Task dialog
  void _showAddTaskDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController dateController = TextEditingController();

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
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Created Date (YYYY-MM-DD)"),
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
                  tasks.add({
                    "name": nameController.text,
                    "status": "Active",
                    "createdAt": dateController.text,
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
