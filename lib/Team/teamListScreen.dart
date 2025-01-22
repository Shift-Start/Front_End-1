import 'package:ShiftStart/Team/createTeamScreen.dart';
import 'package:ShiftStart/Team/editTeamScreen.dart';
import 'package:ShiftStart/Team/teamDetails.dart';
import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
        centerTitle: true,
        backgroundColor: AppColors.lightButton,
      ),
      body: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          return teamProvider.teams.isEmpty
              ? Center(
                  child: Text("No teams yet!",
                      style: TextStyle(fontSize: 16, color: Colors.grey)))
              : ListView.builder(
                  itemCount: teamProvider.teams.length,
                  itemBuilder: (context, index) {
                    final team = teamProvider.teams[index];
                    return ListTile(
                      title: Text(team.name),
                      subtitle: Text(team.scope),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTeamScreen(
                                    team: team,
                                    teamIndex: index,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              Provider.of<TeamProvider>(context, listen: false)
                                  .removeTeam(index);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TeamDetailsScreen(teamIndex: 0),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.lightButton,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTeamScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
