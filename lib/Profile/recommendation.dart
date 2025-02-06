import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart'; 

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  int _charCount = 0;
  final int _maxChars = 500;

  void _sendRecommendation(BuildContext context) {
    if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all fields before submitting."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              Theme.of(context).cardColor, // استخدام اللون المحدد للثيم
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Submission Successful!",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color)),
          content: Text(
            "Thank you for your recommendation! It will be reviewed soon.",
            style: TextStyle(
              color: Provider.of<UiProvider>(context).isDark
                  ? AppColors.darkSecondaryText
                  : AppColors.lightSecondaryText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _titleController.clear();
                _messageController.clear();
                setState(() {
                  _charCount = 0;
                });
              },
              child: Text("OK",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<UiProvider>(context).isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendation"),
        centerTitle: true,
       
          backgroundColor: Theme.of(context).primaryColor,// تغيير اللون حسب الوضع
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recommendation Title:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkPrimaryText
                      : AppColors.lightPrimaryText, // لون العنوان
                )),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Example: Appreciation, Suggestion, Complaint...",
                filled: true,
                fillColor: Theme.of(context).cardColor, // لون الخلفية حسب الثيم
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
            SizedBox(height: 16),
            Text("Recommendation Message:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkPrimaryText
                      : AppColors.lightPrimaryText, // لون العنوان
                )),
            SizedBox(height: 8),
            TextField(
              controller: _messageController,
              maxLines: 5,
              maxLength: _maxChars,
              onChanged: (text) {
                setState(() {
                  _charCount = text.length;
                });
              },
              decoration: InputDecoration(
                hintText: "Write your recommendation here...",
                filled: true,
                fillColor: Theme.of(context).cardColor, // لون الخلفية حسب الثيم
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "$_charCount/$_maxChars",
                style: TextStyle(
                  color: isDark
                      ? AppColors.darkSecondaryText
                      : AppColors.lightSecondaryText, // اللون لعداد الأحرف
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).primaryColor, // اللون حسب الوضع
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.send, color: Colors.white),
                label: Text("Send",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                onPressed: () => _sendRecommendation(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
