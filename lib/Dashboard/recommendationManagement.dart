import 'package:flutter/material.dart';

class RecommendationsManagement extends StatefulWidget {
  @override
  _RecommendationsManagementState createState() => _RecommendationsManagementState();
}

class _RecommendationsManagementState extends State<RecommendationsManagement> {
  // قائمة وهمية بالتوصيات
  List<Map<String, dynamic>> recommendations = [
    {
      "user": "John Doe",
      "content": "I suggest adding a dark mode feature.",
      "date": "2025-02-01",
      "archived": false,
    },
    {
      "user": "Sarah Ahmed",
      "content": "It would be great to have more detailed analytics.",
      "date": "2025-01-28",
      "archived": false,
    },
    {
      "user": "Mike Johnson",
      "content": "Improve the notification system for better user engagement.",
      "date": "2025-01-25",
      "archived": true, // مثال لتوصية مؤرشفة
    },
  ];

  // فلترة التوصيات حسب الحالة (نشطة/مؤرشفة)
  bool showArchived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recommendations Management")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 فلترة التوصيات (نشطة أو مؤرشفة)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showArchived ? "Archived Recommendations" : "Active Recommendations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: showArchived,
                  onChanged: (value) {
                    setState(() {
                      showArchived = value;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            // 📋 قائمة التوصيات
            Expanded(
              child: ListView.builder(
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = recommendations[index];

                  // عرض التوصيات حسب الفلترة
                  if (recommendation["archived"] != showArchived) return SizedBox.shrink();

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.recommend, color: Colors.blue),
                      title: Text(recommendation["user"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recommendation["content"], maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(
                            "Sent on: ${recommendation["date"]}",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // زر عرض التفاصيل
                          IconButton(
                            icon: Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () {
                              _showRecommendationDetails(context, recommendation);
                            },
                          ),
                          // زر أرشفة/إلغاء الأرشفة
                          IconButton(
                            icon: Icon(
                              recommendation["archived"] ? Icons.unarchive : Icons.archive,
                              color: recommendation["archived"] ? Colors.green : Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                recommendation["archived"] = !recommendation["archived"];
                              });
                            },
                          ),
                          // زر حذف التوصية
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteRecommendation(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 عرض تفاصيل التوصية
  void _showRecommendationDetails(BuildContext context, Map<String, dynamic> recommendation) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Recommendation Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("User: ${recommendation["user"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Content:\n${recommendation["content"]}"),
              SizedBox(height: 8),
              Text("Sent on: ${recommendation["date"]}", style: TextStyle(color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // 🔹 حذف التوصية
  void _deleteRecommendation(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Recommendation"),
          content: Text("Are you sure you want to delete this recommendation?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  recommendations.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
     },
);
}
}
