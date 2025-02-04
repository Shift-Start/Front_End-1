import 'package:flutter/material.dart';

class TemplateManagement extends StatefulWidget {
  @override
  _TemplateManagementState createState() => _TemplateManagementState();
}

class _TemplateManagementState extends State<TemplateManagement> {
  // Sample templates data
  List<Map<String, dynamic>> templates = [
    {
      "name": "Template 1",
      "description": "This is template 1",
      "created": "2024-01-10"
    },
    {
      "name": "Template 2",
      "description": "This is template 2",
      "created": "2024-02-05"
    },
    {
      "name": "Template 3",
      "description": "This is template 3",
      "created": "2024-03-15"
    },
  ];

  // Function to add a new template
  void _showAddTemplateDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Template"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Template Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Template Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                setState(() {
                  templates.add({
                    "name": nameController.text,
                    "description": descriptionController.text,
                    "created": DateTime.now().toString().split(' ')[0],
                  });
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to edit an existing template
  void _showEditTemplateDialog(int index) {
    TextEditingController nameController =
        TextEditingController(text: templates[index]["name"]);
    TextEditingController descriptionController =
        TextEditingController(text: templates[index]["description"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Template"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Template Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Template Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Save Changes"),
              onPressed: () {
                setState(() {
                  templates[index]["name"] = nameController.text;
                  templates[index]["description"] = descriptionController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to delete a template
  void _deleteTemplate(int index) {
    setState(() {
      templates.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Template Management"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                labelText: "Search Templates...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // List of templates
            Expanded(
              child: ListView.builder(
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(template["name"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(template["description"]),
                          Text("Created: ${template["created"]}",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditTemplateDialog(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTemplate(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Add new template button
            ElevatedButton.icon(
              onPressed: _showAddTemplateDialog,
              icon: Icon(Icons.add),
              label: Text("Add New Template"),
            ),
          ],
        ),
      ),
    );
  }
}
