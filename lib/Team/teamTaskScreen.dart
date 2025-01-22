import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TeamTasksScreen extends StatelessWidget {
  final Team team;

  TeamTasksScreen({required this.team});

  final TextEditingController taskTitleController = TextEditingController();

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
                        subtitle: task.assignedTo != null
                            ? Text("Assigned to: ${task.assignedTo}")
                            : Text("Unassigned"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            final provider = Provider.of<TeamProvider>(context, listen: false);
                            final teamIndex = provider.teams.indexOf(team);
                            provider.removeTask(teamIndex, index);
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(labelText: "Task Title"),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (taskTitleController.text.isNotEmpty) {
                      final newTask = Task(
                        title: taskTitleController.text, description: '',
                      );
                      final provider = Provider.of<TeamProvider>(context, listen: false);
                      final teamIndex = provider.teams.indexOf(team);
                      provider.addTask(teamIndex, newTask);
                      taskTitleController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightButton),
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ],
    ),
);
}
}
