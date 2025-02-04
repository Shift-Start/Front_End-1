import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'teamListScreen.dart';
import 'teamProvider.dart';

class CreateTeamScreen extends StatelessWidget {
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController scopeController = TextEditingController();
  final TextEditingController teamDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Team"),
        centerTitle: true,
        backgroundColor: AppColors.lightButton, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Team Name",
                style:
                    TextStyle(fontSize: 18, color:Colors.white)),
            TextField(controller: teamNameController),
            SizedBox(height: 20),
            Text("Scope",
                style:
                    TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            TextField(controller: scopeController),
            SizedBox(height: 20),
            Text("Description",
                style:
                    TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            TextField(controller: teamDescriptionController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (teamNameController.text.isNotEmpty &&
                    scopeController.text.isNotEmpty &&
                    teamDescriptionController.text.isNotEmpty) {
                  Team newTeam = Team(
                    name: teamNameController.text,
                    scope: scopeController.text,
                    description: teamDescriptionController.text,
                    members: [],
                    tasks: [],
                    chatIds: [],
                  );
                  Provider.of<TeamProvider>(context, listen: false)
                      .addTeam(newTeam);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TeamsListScreen()),   
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Create Team", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
