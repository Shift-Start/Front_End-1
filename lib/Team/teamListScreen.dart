import 'package:ShiftStart/Conversation/teamChatsScreen.dart';
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
    final teamProvider = Provider.of<TeamProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          return teamProvider.teams.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.groups,
                            size: 120, color: Theme.of(context).primaryColor),
                        SizedBox(height: 20),
                        Text(
                          "No Teams Yet!",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ]),
                )
              : ListView.builder(
                  itemCount: teamProvider.teams.length,
                  itemBuilder: (context, index) {
                    final team = teamProvider.teams[index];
                    return Card(
                        child: ListTile(
                      title: Text(team.name),
                      subtitle: Text(team.scope),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TeamChatsScreen(
                                            teamId: team.name)));
                              },
                              icon: Icon(Icons.chat)),
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
                    ));
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTeamScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
