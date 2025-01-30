// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../colors.dart';
// import 'teamProvider.dart';
 

// class TeamSettingsScreen extends StatefulWidget {
//   final Team team;
//   final int index;

//   TeamSettingsScreen({required this.team, required this.index});

//   @override
//   _TeamSettingsScreenState createState() => _TeamSettingsScreenState();
// }

// class _TeamSettingsScreenState extends State<TeamSettingsScreen> {
//   String? selectedRole;

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController teamNameController = TextEditingController(text: widget.team.name);
//     TextEditingController scopeController = TextEditingController(text: widget.team.scope);
//     TextEditingController teamDescriptionController = TextEditingController(text: widget.team.description);
//     TextEditingController memberController = TextEditingController();  // Controller لإضافة الأعضاء

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit ${widget.team.name}"),
//         backgroundColor: AppColors.lightButton,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // تعديل اسم الفريق
//             TextField(
//               controller: teamNameController,
//               decoration: InputDecoration(
//                 labelText: "Team Name",
//                 labelStyle: TextStyle(color: AppColors.lightPrimaryText),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),

//             // تعديل نطاق الفريق
//             TextField(
//               controller: scopeController,
//               decoration: InputDecoration(
//                 labelText: "Scope",
//                 labelStyle: TextStyle(color: AppColors.lightPrimaryText),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),

//             // تعديل وصف الفريق
//             TextField(
//               controller: teamDescriptionController,
//               decoration: InputDecoration(
//                 labelText: "Description",
//                 labelStyle: TextStyle(color: AppColors.lightPrimaryText),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),

//             // إضافة عضو جديد إلى الفريق
//             TextField(
//               controller: memberController,
//               decoration: InputDecoration(
//                 hintText: 'Enter Member ID',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     // إضافة العضو
//                     if (memberController.text.isNotEmpty) {
//                       Provider.of<TeamProvider>(context, listen: false).addMember(widget.index, memberController.text);
//                       memberController.clear();  // مسح حقل الإدخال بعد إضافة العضو
//                     }
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             // عرض الأعضاء الحاليين في الفريق
//             Text("Current Members:", style: TextStyle(fontSize: 16, color: AppColors.lightPrimaryText)),
//             for (int i = 0; i < widget.team.members.length; i++)
//               ListTile(
//                 title: Text(widget.team.members[i], style: TextStyle(color: AppColors.lightPrimaryText)),
//                 trailing: DropdownButton<String>(
//                   value: selectedRole,
//                   items: ['Admin', 'Member'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedRole = value!;
//                     });
//                     // تحديث صلاحية العضو
//                     Provider.of<TeamProvider>(context, listen: false).assignTask(widget.index, i, selectedRole!);
//                   },
//                 ),
//               ),
//             SizedBox(height: 20),

//             // حفظ التعديلات
//             ElevatedButton(
//               onPressed: () {
//                 Team updatedTeam = Team(
//                   name: teamNameController.text,
//                   scope: scopeController.text,
//                   description: teamDescriptionController.text,
//                   members: widget.team.members,
//                   tasks: widget.team.tasks,
//                 );
//                 Provider.of<TeamProvider>(context, listen: false).editTeam(widget.index, updatedTeam);
//                 Navigator.pop(context);  // العودة إلى "قائمة الفرق"
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.lightButton,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: Text("Save Changes", style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//      ),
// );
// }
// }
