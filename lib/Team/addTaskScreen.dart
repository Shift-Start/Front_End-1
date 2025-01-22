import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddTasksScreen extends StatefulWidget {
  final int teamIndex;

  AddTasksScreen({required this.teamIndex});

  @override
  _AddTasksScreenState createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  String? selectedMember;

  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context);
    final team = teamProvider.teams[widget.teamIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Tasks"),
        backgroundColor: AppColors.lightButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: TextStyle(fontSize: 20, color: AppColors.lightPrimaryText),
            ),
            SizedBox(height: 10),
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(
                hintText: "Enter Task Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: taskDescriptionController,
              decoration: InputDecoration(
                hintText: "Enter Task Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedMember,
              hint: Text("Assign to Member (Optional)"),
              items: team.members.map((member) {
                return DropdownMenuItem<String>(
                  value: member.name,
                  child: Text(member.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMember = value;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (taskNameController.text.isNotEmpty &&
                    taskDescriptionController.text.isNotEmpty) {
                  teamProvider.addTask(
                    widget.teamIndex,
                    Task(
                      title: taskNameController.text,
                      description: taskDescriptionController.text,
                      assignedTo: selectedMember,
                    ),
                  );
                  taskNameController.clear();
                  taskDescriptionController.clear();
                  setState(() {
                    selectedMember = null; 
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Add Task", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              "Team Tasks",
              style: TextStyle(fontSize: 20, color: AppColors.lightPrimaryText),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: team.tasks.length,
                itemBuilder: (context, index) {
                  final task = team.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(
                        "Assigned to: ${task.assignedTo ?? 'Unassigned'}\n${task.description}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showEditTaskDialog(context, index, task);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            teamProvider.removeTask(widget.teamIndex, index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, int index, Task task) {
    final TextEditingController editTaskNameController =
        TextEditingController(text: task.title);
    final TextEditingController editTaskDescriptionController =
        TextEditingController(text: task.description);
    String? editAssignedMember = task.assignedTo;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTaskNameController,
                decoration: InputDecoration(
                  hintText: "Enter Task Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: editTaskDescriptionController,
                decoration: InputDecoration(
                  hintText: "Enter Task Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: editAssignedMember,
                hint: Text("Assign to Member (Optional)"),
                items: Provider.of<TeamProvider>(context, listen: false)
                    .teams[widget.teamIndex]
                    .members
                    .map((member) {
                  return DropdownMenuItem<String>(
                    value: member.name,
                    child: Text(member.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    editAssignedMember = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (editTaskNameController.text.isNotEmpty &&
                    editTaskDescriptionController.text.isNotEmpty) {
                  Provider.of<TeamProvider>(context, listen: false)
                      .updateTask(
                    widget.teamIndex,
                    index,
                    Task(
                      title: editTaskNameController.text,
                      description: editTaskDescriptionController.text,
                      assignedTo: editAssignedMember,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
              ),
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
     },
);
}
}
