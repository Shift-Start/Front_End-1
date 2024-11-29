import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'menuScreen.dart';
import 'package:provider/provider.dart';
// استيراد UiProvider

class NewAssignmentScreen extends StatefulWidget {
  @override
  _NewAssignmentScreenState createState() => _NewAssignmentScreenState();
}

class _NewAssignmentScreenState extends State<NewAssignmentScreen> {
  bool allDay = true;
  bool alert = true;
  bool ischeck = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<UiProvider>(context); // الحصول على حالة الثيم
    final isDark = themeProvider.isDark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'New Assignment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'DMSans_18pt-Bold',
            color:
                isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText,
          ),
        ),
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: 4,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MenuScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'icons/Icon.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Eg. Read Book',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelStyle: TextStyle(
                        color: isDark
                            ? AppColors.darkPrimaryText
                            : AppColors.lightPrimaryText),
                    hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.darkSecondaryText
                            : AppColors.lightSecondaryText),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // Dropdown Field
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Class name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelStyle: TextStyle(
                        color: isDark
                            ? AppColors.darkPrimaryText
                            : AppColors.lightPrimaryText),
                  ),
                  items: [
                    DropdownMenuItem(
                        child: Text("MGT 101 - Organization Management"),
                        value: "MGT 101 - Organization Management"),
                  ],
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 20.0),
              // Details Field
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Details',
                    hintText: 'Eg. Read from page 100 to 150',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelStyle: TextStyle(
                        color: isDark
                            ? AppColors.darkPrimaryText
                            : AppColors.lightPrimaryText),
                    hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.darkSecondaryText
                            : AppColors.lightSecondaryText),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 20.0),
              // Priority Checkbox
              Row(
                children: [
                  Checkbox(
                    value: ischeck,
                    onChanged: (val) {
                      setState(() {
                        ischeck = val!;
                      });
                    },
                  ),
                  Text(
                    'Set as priority',
                    style: TextStyle(
                        color: isDark
                            ? AppColors.darkPrimaryText
                            : AppColors.lightPrimaryText),
                  ),
                ],
              ),
              Divider(),
              // All day Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All day',
                    style: TextStyle(
                      fontFamily: 'DMSans_18pt-Bold',
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Switch(
                    activeColor: AppColors.darkButton,
                    value: allDay,
                    onChanged: (value) {
                      setState(() {
                        allDay = value;
                      });
                    },
                  ),
                ],
              ),
              ListTile(
                title: Text(
                  "Monday, 18th Oct",
                  style: TextStyle(
                    color: isDark
                        ? AppColors.darkPrimaryText
                        : AppColors.lightPrimaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              // Alert Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alert',
                    style: TextStyle(
                      fontFamily: 'DMSans_18pt-Bold',
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Switch(
                    activeColor: AppColors.darkButton,
                    value: alert,
                    onChanged: (value) {
                      setState(() {
                        alert = value;
                      });
                    },
                  ),
                ],
              ),
              ListTile(
                title: Text(
                  "1 day before class",
                  style: TextStyle(
                    color: isDark
                        ? AppColors.darkPrimaryText
                        : AppColors.lightPrimaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.darkButton, // تغير اللون هنا حسب الثيم
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.darkButton),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
