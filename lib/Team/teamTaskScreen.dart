import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'teamProvider.dart';
import '../colors.dart';

class TeamTasksScreen extends StatelessWidget {
  final Team team;

  TeamTasksScreen({required this.team});

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  DateTime? startTime;
  DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${team.name} Tasks"),
        centerTitle: true,
        backgroundColor: AppColors.lightButton,
      ),
      body: Column(
        children: [
          Expanded(
            child: team.tasks.isEmpty
                ? Center(
                    child: Text(
                      "No tasks yet!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: team.tasks.length,
                    itemBuilder: (context, index) {
                      final task = team.tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text(
                          "Start: ${task.startTime?.toString().substring(0, 16) ?? 'N/A'}\n"
                          "End: ${task.endTime?.toString().substring(0, 16) ?? 'N/A'}\n"
                          "Assigned to: ${task.assignedTo ?? 'Unassigned'}",
                        ),
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
                                final provider = Provider.of<TeamProvider>(
                                    context,
                                    listen: false);
                                final teamIndex = provider.teams.indexOf(team);
                                provider.removeTask(teamIndex, index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Task",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: taskTitleController,
                  decoration: InputDecoration(
                    labelText: "Task Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: taskDescriptionController,
                  decoration: InputDecoration(
                    labelText: "Task Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              startTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightButton),
                        child: Text("Pick Start Time",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              endTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightButton),
                        child: Text("Pick End Time",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (taskTitleController.text.isNotEmpty &&
                        taskDescriptionController.text.isNotEmpty &&
                        startTime != null &&
                        endTime != null) {
                      final newTask = Task(
                        title: taskTitleController.text,
                        description: taskDescriptionController.text,
                        startTime: startTime,
                        endTime: endTime,
                      );
                      final provider =
                          Provider.of<TeamProvider>(context, listen: false);
                      final teamIndex = provider.teams.indexOf(team);
                      provider.addTask(teamIndex, newTask);
                      taskTitleController.clear();
                      taskDescriptionController.clear();
                      startTime = null;
                      endTime = null;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightButton),
                  child:
                      Text("Add Task", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, int index, Task task) {
    final TextEditingController editTaskTitleController =
        TextEditingController(text: task.title);
    final TextEditingController editTaskDescriptionController =
        TextEditingController(text: task.description);
    DateTime? editStartTime = task.startTime;
    DateTime? editEndTime = task.endTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTaskTitleController,
                decoration: InputDecoration(labelText: "Task Title"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: editTaskDescriptionController,
                decoration: InputDecoration(labelText: "Task Description"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightButton,
                ),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      editStartTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    }
                  }
                },
                child: Text("Pick Start Time"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightButton,
                ),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      editEndTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    }
                  }
                },
                child: Text("Pick End Time"),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
              ),
              onPressed: () {
                if (editTaskTitleController.text.isNotEmpty &&
                    editTaskDescriptionController.text.isNotEmpty &&
                    editStartTime != null &&
                    editEndTime != null) {
                  Provider.of<TeamProvider>(context, listen: false).updateTask(
                    Provider.of<TeamProvider>(context, listen: false)
                        .teams
                        .indexOf(team),
                    index,
                    Task(
                      title: editTaskTitleController.text,
                      description: editTaskDescriptionController.text,
                      startTime: editStartTime,
                      endTime: editEndTime,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
