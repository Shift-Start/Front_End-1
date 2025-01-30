import 'package:ShiftStart/Team/teamProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 

class MembersScreen extends StatefulWidget {
  final int teamIndex; // تحديد الفريق من خلال الفهرس

  MembersScreen({required this.teamIndex});

  @override
  _TeamMembersScreenState createState() => _TeamMembersScreenState();
}

class _TeamMembersScreenState extends State<MembersScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context);
    final team = teamProvider.teams[widget.teamIndex];

    List<Member> filteredMembers = team.members
        .where((member) =>
            member.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            member.role.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.orange),
            onPressed: () => _showAddMemberDialog(context, teamProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member = filteredMembers[index];
                return Dismissible(
                  key: Key(member.name),
                  background: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed: (direction) {
                    teamProvider.removeMember(widget.teamIndex, index);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      child: Text(member.name[0].toUpperCase(),
                          style: TextStyle(color: Colors.white)),
                    ),
                    title: Text(member.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(member.role, style: TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search member",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context, TeamProvider teamProvider) {
    TextEditingController nameController = TextEditingController();
    TextEditingController roleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Member"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(hintText: "Enter name")),
              SizedBox(height: 10),
              TextField(controller: roleController, decoration: InputDecoration(hintText: "Enter role")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && roleController.text.isNotEmpty) {
                  teamProvider.addMember(widget.teamIndex, Member(name: nameController.text, role: roleController.text));
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
     },
);
}
}
