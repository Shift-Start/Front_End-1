import 'package:flutter/material.dart';

class TeamManagement extends StatefulWidget {
  const TeamManagement({super.key});

  @override
  _TeamManagementState createState() => _TeamManagementState();
}

class _TeamManagementState extends State<TeamManagement> {
  // قائمة الفرق
  List<Map<String, dynamic>> teams = [
    {"name": "Team A", "members": 10},
    {"name": "Team B", "members": 5},
    {"name": "Team C", "members": 8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Management"),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Search for a team...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.group)),
                      title: Text(team["name"]),
                      subtitle: Text("Members: ${team["members"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                         children: [
                        //   IconButton(
                        //     icon: const Icon(Icons.edit),
                        //     onPressed: () {
                        //       // Edit team functionality
                        //     },
                        //   ),
                        //   IconButton(
                        //     icon: const Icon(Icons.delete, color: Colors.red),
                        //     onPressed: () {
                        //       setState(() {
                        //         teams.removeAt(index);
                        //       });
                        //     },
                        //   ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Add new team functionality
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Team"),
            ),
          ],
        ),
     ),
);
}
}
