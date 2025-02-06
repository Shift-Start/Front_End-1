import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'teamProvider.dart';


class TeamMembersScreen extends StatelessWidget {
  final Team team;

  TeamMembersScreen({required this.team});

  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController memberRoleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${team.name} Members"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: team.members.isEmpty
                ? Center(
                    child: Text(
                      "No members in this team!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: team.members.length,
                    itemBuilder: (context, index) {
                      final member = team.members[index];
                      return ListTile(
                        title: Text(member.name),
                        subtitle: Text(member.role),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            final provider = Provider.of<TeamProvider>(context, listen: false);
                            final teamIndex = provider.teams.indexOf(team);
                            provider.removeMember(teamIndex, index);
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
                    controller: memberNameController,
                    decoration: InputDecoration(labelText: "Member Name"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: memberRoleController,
                    decoration: InputDecoration(labelText: "Member Role"),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (memberNameController.text.isNotEmpty && memberRoleController.text.isNotEmpty) {
                      final newMember = Member(
                        name: memberNameController.text,
                        role: memberRoleController.text,
                      );
                      final provider = Provider.of<TeamProvider>(context, listen: false);
                      final teamIndex = provider.teams.indexOf(team);
                      provider.addMember(teamIndex, newMember);
                      memberNameController.clear();
                      memberRoleController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
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
