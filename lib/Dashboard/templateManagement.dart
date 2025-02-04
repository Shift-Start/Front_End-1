import 'package:flutter/material.dart';


import 'themeColor.dart'; 

class TemplateManagement extends StatefulWidget {
  const TemplateManagement({super.key});

  @override
  _TemplateManagementState createState() => _TemplateManagementState();
}

class _TemplateManagementState extends State<TemplateManagement> {
  List<Map<String, dynamic>> templates = [
    {"name": "Template 1", "description": "This is template 1", "created": "2024-01-10"},
    {"name": "Template 2", "description": "This is template 2", "created": "2024-02-05"},
    {"name": "Template 3", "description": "This is template 3", "created": "2024-03-15"},
  ];

  void _showAddTemplateDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Template"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Template Name")),
              TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Template Description")),
            ],
          ),
          actions: [
            TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
              child: const Text("Add"),
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

  void _showEditTemplateDialog(int index) {
    TextEditingController nameController = TextEditingController(text: templates[index]["name"]);
    TextEditingController descriptionController = TextEditingController(text: templates[index]["description"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Template"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Template Name")),
              TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Template Description")),
            ],
          ),
          actions: [
            TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
              child: const Text("Save Changes"),
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

  void _deleteTemplate(int index) {
    setState(() {
      templates.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Template Management"),
        backgroundColor: AppColors.lightButton, // لون متناسق مع الثيم
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شريط البحث
            const TextField(
              decoration: InputDecoration(
                labelText: "Search Templates...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // قائمة القوالب
            Expanded(
              child: ListView.builder(
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: AppColors.lightCard, // لون البطاقة
                    child: ListTile(
                      title: Text(
                        template["name"],
                        style: TextStyle(color: AppColors.lightPrimaryText),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(template["description"],
                              style: TextStyle(color: AppColors.lightPrimaryText)),
                          Text("Created: ${template["created"]}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditTemplateDialog(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTemplate(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // زر إضافة قالب جديد
            ElevatedButton.icon(
              onPressed: _showAddTemplateDialog,
              icon: const Icon(Icons.add),
              label: const Text("Add New Template"),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightButton), // لون الزر
            ),
          ],
        ),
     ),
);
}
}
