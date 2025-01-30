import 'package:ShiftStart/Team/member.dart';
import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'addMemberScreen.dart';
import 'addTaskScreen.dart';

class TeamDetailsScreen extends StatelessWidget {
  final int teamIndex;

  TeamDetailsScreen({required this.teamIndex});

  @override
  Widget build(BuildContext context) {
    final team = Provider.of<TeamProvider>(context).teams[teamIndex];
    final teamProvider = Provider.of<TeamProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
        centerTitle: true,
        backgroundColor: AppColors.lightButton,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MembersScreen(teamIndex: teamIndex)));
              },
              icon: Icon(Icons.group))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Scope: ${team.scope}",
                style:
                    TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            SizedBox(height: 10),
            Text("Description: ${team.description}",
                style: TextStyle(
                    fontSize: 16, color: AppColors.lightSecondaryText)),
            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMemberScreen(teamIndex: teamIndex),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.group, color: Colors.white),
              label:
                  Text("Manage Members", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),

            // زر إدارة المهام
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTasksScreen(teamIndex: teamIndex),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.task, color: Colors.white),
              label:
                  Text("Manage Tasks", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),

            Text("Team Members",
                style:
                    TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            Expanded(
              child: ListView.builder(
                itemCount: team.members.length,
                itemBuilder: (context, index) {
                  final member = team.members[index];
                  return ListTile(
                    title: Text(member.name),
                    subtitle: Text("Role: ${member.role}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Provider.of<TeamProvider>(context, listen: false)
                            .removeMember(teamIndex, index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${member.name} removed!")),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // عرض المهام الحالية
            Text("Team Tasks",
                style:
                    TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            Expanded(
              child: ListView.builder(
                itemCount: team.tasks.length,
                itemBuilder: (context, index) {
                  final task = team.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle:
                        Text("Assigned to: ${task.assignedTo ?? 'Unassigned'}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Provider.of<TeamProvider>(context, listen: false)
                            .removeTask(teamIndex, index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Task '${task.title}' removed!")),
                        );
                      },
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
}
