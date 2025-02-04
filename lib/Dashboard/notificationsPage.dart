import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShiftStart/Dashboard/themeColor.dart'; 


class NotificationManagementPage extends StatefulWidget {
  @override
  _NotificationManagementPageState createState() =>
      _NotificationManagementPageState();
}

class _NotificationManagementPageState
    extends State<NotificationManagementPage> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification sent!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProviderAdmain>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Management"),
        backgroundColor: themeProvider.isDark
            ? Colors.black
            : AppColors.lightButton, // استخدم اللون المناسب من AppColors
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  اختيار المستلم
            Text("Select Recipient:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDark
                        ? Colors.white
                        : AppColors.lightPrimaryText)),
            DropdownButton<String>(
              value: selectedRecipient,
              items: recipients.map((recipient) {
                return DropdownMenuItem(
                    value: recipient, child: Text(recipient));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRecipient = value!;
                });
              },
            ),
            SizedBox(height: 10),

            // 🔹 إدخال نص الإشعار
            Text("Notification Message:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDark
                        ? Colors.white
                        : AppColors.lightPrimaryText)),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter your message...",
                border: OutlineInputBorder(),
                hintStyle: TextStyle(
                    color: themeProvider.isDark
                        ? Colors.white70
                        : Colors.black45),
              ),
              style: TextStyle(
                  color:
                      themeProvider.isDark ? Colors.white : Colors.black), // تغيير النص حسب الثيم
            ),
            SizedBox(height: 10),

            // 🔹 زر الإرسال
            ElevatedButton(
              onPressed: sendNotification,
              child: Text("Send Notification"),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.isDark
                    ? Colors.blueGrey
                    : AppColors.lightButton, // تخصيص اللون حسب الثيم
              ),
            ),
            SizedBox(height: 20),
            Divider(),

            // 🔹 قائمة الإشعارات المرسلة
            Text("Sent Notifications:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDark
                        ? Colors.white
                        : AppColors.lightPrimaryText)),
            Expanded(
              child: ListView.builder(
                itemCount: sentNotifications.length,
                itemBuilder: (context, index) {
                  final notification = sentNotifications[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: themeProvider.isDark
                        ? Colors.grey[800]
                        : Colors.white, // تخصيص اللون حسب الثيم
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: themeProvider.isDark
                            ? Colors.white
                            : Colors.blue, // تخصيص اللون حسب الثيم
                      ),
                      title: Text(
                        notification["message"]!,
                        style: TextStyle(
                            color: themeProvider.isDark
                                ? Colors.white
                                : Colors.black),
                      ),
                      subtitle: Text(
                        "To: ${notification["recipient"]}",
                        style: TextStyle(
                            color: themeProvider.isDark
                                ? Colors.white70
                                : Colors.black45),
                      ),
                      trailing: Text(
                        notification["time"]!,
                        style: TextStyle(
                            color: themeProvider.isDark
                                ? Colors.white70
                                : Colors.black45),
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
}
