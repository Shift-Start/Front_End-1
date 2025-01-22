import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import 'teamProvider.dart';

class AddMemberScreen extends StatefulWidget {
  final int teamIndex; // لتحديد الفريق الذي نضيف فيه العضو

  AddMemberScreen({required this.teamIndex});

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController nameController = TextEditingController();
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Member"),
        backgroundColor: AppColors.lightButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Member Name",
                style: TextStyle(
                    fontSize: 18, color: AppColors.lightPrimaryText)),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter member name",
              ),
            ),
            SizedBox(height: 20),
            Text("Role",
                style: TextStyle(
                    fontSize: 18, color: AppColors.lightPrimaryText)),
            DropdownButton<String>(
              value: selectedRole,
              items: ['Admin', 'Member'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text("Select Role"),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && selectedRole != null) {
                  // إضافة العضو إلى الفريق
                  final member = Member(
                    name: nameController.text,
                    role: selectedRole!,
                  );
                  Provider.of<TeamProvider>(context, listen: false)
                      .addMember(widget.teamIndex, member);

                  // العودة إلى شاشة الفريق
                  Navigator.pop(context);
                } else {
                  // رسالة خطأ في حال الحقول فارغة
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all fields")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightButton,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Add Member", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
     ),
);
}
}
