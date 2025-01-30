import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EditTeamScreen extends StatefulWidget {
  final Team team;
  final int teamIndex;

  EditTeamScreen({required this.team, required this.teamIndex});

  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  late TextEditingController nameController;
  late TextEditingController scopeController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.team.name);
    scopeController = TextEditingController(text: widget.team.scope);
    descriptionController = TextEditingController(text: widget.team.description);
  }

  @override
  void dispose() {
    nameController.dispose();
    scopeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Team"),
        centerTitle: true,
        backgroundColor: AppColors.lightButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // تعديل الاسم
            Text("Team Name",
                style: TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            TextField(controller: nameController),
            SizedBox(height: 20),
            // تعديل المجال (Scope)
            Text("Scope",
                style: TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            TextField(controller: scopeController),
            SizedBox(height: 20),
            // تعديل الوصف
            Text("Description",
                style: TextStyle(fontSize: 18, color: AppColors.lightPrimaryText)),
            TextField(controller: descriptionController),
            SizedBox(height: 20),
            // زر الحفظ
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    scopeController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  Provider.of<TeamProvider>(context, listen: false).updateTeam(
                    widget.teamIndex,
                    Team(
                      name: nameController.text,
                      scope: scopeController.text,
                      description: descriptionController.text,
                      members: widget.team.members,
                      tasks: widget.team.tasks,
                      chatIds: widget.team.chatIds,
                    ),
                  );
                  Navigator.pop(context); 
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Save Changes", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
     ),
);
}
}
