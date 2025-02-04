import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShiftStart/Dashboard/themeColor.dart';


class RecommendationsManagement extends StatefulWidget {
  @override
  _RecommendationsManagementState createState() => _RecommendationsManagementState();
}

class _RecommendationsManagementState extends State<RecommendationsManagement> {
  List<Map<String, dynamic>> recommendations = [
    {"user": "John Doe", "content": "I suggest adding a dark mode feature.", "date": "2025-02-01", "archived": false},
    {"user": "Sarah Ahmed", "content": "It would be great to have more detailed analytics.", "date": "2025-01-28", "archived": false},
    {"user": "Mike Johnson", "content": "Improve the notification system for better user engagement.", "date": "2025-01-25", "archived": true},
  ];

  bool showArchived = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProviderAdmain>(context);
    bool isDark = themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendations Management"),
        backgroundColor: isDark ? Colors.black : AppColors.lightButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //  فلترة التوصيات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showArchived ? "Archived Recommendations" : "Active Recommendations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                ),
                Switch(
                  value: showArchived,
                  onChanged: (value) {
                    setState(() {
                      showArchived = value;
                    });
                  },
                  activeColor: AppColors.lightBackground,
                ),
              ],
            ),
            const SizedBox(height: 16),

            //  قائمة التوصيات
            Expanded(
              child: ListView.builder(
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = recommendations[index];

                  if (recommendation["archived"] != showArchived) return const SizedBox.shrink();

                  return Card(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: isDark ? Colors.white : Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.recommend, color: isDark ? Colors.white : Colors.blue),
                      title: Text(recommendation["user"], style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recommendation["content"], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black)),
                          Text(
                            "Sent on: ${recommendation["date"]}",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility, color: isDark ? Colors.white : Colors.blue),
                            onPressed: () {
                              _showRecommendationDetails(context, recommendation, isDark);
                            },
                          ),
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
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteRecommendation(index, isDark);
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

  //  عرض تفاصيل التوصية
  void _showRecommendationDetails(BuildContext context, Map<String, dynamic> recommendation, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          title: Text("Recommendation Details", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("User: ${recommendation["user"]}", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 8),
              Text("Content:\n${recommendation["content"]}", style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black)),
              const SizedBox(height: 8),
              Text("Sent on: ${recommendation["date"]}", style: TextStyle(color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close", style: TextStyle(color: isDark ? Colors.white : Colors.blue)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //  حذف التوصية
  void _deleteRecommendation(int index, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          title: Text("Delete Recommendation", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          content: Text("Are you sure you want to delete this recommendation?", style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black)),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: isDark ? Colors.white : Colors.blue)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
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
