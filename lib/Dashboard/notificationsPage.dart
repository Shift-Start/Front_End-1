import 'package:flutter/material.dart';

class NotificationManagementPage extends StatefulWidget {
  @override
  _NotificationManagementPageState createState() => _NotificationManagementPageState();
}

class _NotificationManagementPageState extends State<NotificationManagementPage> {
  String selectedRecipient = "All";
  TextEditingController messageController = TextEditingController();

  List<String> recipients = ["All", "Team A", "Team B", "User 1", "User 2"];
  List<Map<String, String>> sentNotifications = [];

  void sendNotification() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        sentNotifications.insert(0, {
          "recipient": selectedRecipient,
          "message": messageController.text,
          "time": DateTime.now().toString().substring(0, 16),
        });
        messageController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification sent!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Management")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 اختيار المستلم
            Text("Select Recipient:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedRecipient,
              items: recipients.map((recipient) {
                return DropdownMenuItem(value: recipient, child: Text(recipient));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRecipient = value!;
                });
              },
            ),
            SizedBox(height: 10),

            // 🔹 إدخال نص الإشعار
            Text("Notification Message:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter your message...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // 🔹 زر الإرسال
            ElevatedButton(
              onPressed: sendNotification,
              child: Text("Send Notification"),
            ),
            SizedBox(height: 20),
            Divider(),

            // 🔹 قائمة الإشعارات المرسلة
            Text("Sent Notifications:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: sentNotifications.length,
                itemBuilder: (context, index) {
                  final notification = sentNotifications[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Icon(Icons.notifications, color: Colors.blue),
                      title: Text(notification["message"]!),
                      subtitle: Text("To: ${notification["recipient"]}"),
                      trailing: Text(notification["time"]!),
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
}
