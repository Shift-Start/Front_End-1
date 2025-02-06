import 'package:ShiftStart/HomeScreen/menuScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Profile/profile.dart';
import '../colors.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedDay = "18"; // اليوم المحدد مبدئيًا

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<UiProvider>(context).isDark;
    final theme = isDark ? ThemeData.dark() : ThemeData.light();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: TextStyle(
            //color: AppColors.lightPrimaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans_18pt-Bold'),
        title: Text(
          "Schedule",
          // style: theme.textTheme.bodyLarge?.copyWith(
          //   fontSize: 24,
          //   fontWeight: FontWeight.bold,
          // )
        ),
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // الصف الخاص بالأيام
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dayHeader("  ", "  ", theme),
                dayHeader("18", "Mon", theme),
                dayHeader("19", "Tue", theme),
                dayHeader("20", "Wed", theme),
                dayHeader("21", "Thu", theme),
                dayHeader("22", "Fri", theme),
                dayHeader("23", "Sat", theme),
                dayHeader("24", "Sun", theme),
              ],
            ),
            SizedBox(height: 10),
            // الشبكة الزمنية للجدول
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: getScheduleForSelectedDay(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لجلب المهام بناءً على اليوم المحدد
  List<Widget> getScheduleForSelectedDay() {
    if (selectedDay == "18") {
      return [
        timeSlotRow("08", [
          classBox("Org Mgt", "Room 101", 'ClasshabitTask'),
          emptyBox(),
        ]),
        timeSlotRow('11', [
          classBox("Financial Mgt", "Room 101", "ClassTask"),
          classBox("Org Mgt", "Room 101", 'ClassTeamTask'),
          classBox("Macro", "Room 101", 'ClassTeamTask'),
        ]),
      ];
    } else if (selectedDay == "19") {
      return [
        timeSlotRow("09", [
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Micro", "Room 101", 'ClasshabitTask'),
          emptyBox(),
          classBox("Macro", "Room 101", 'ClassTeamTask'),
          emptyBox(),
        ]),
      ];
    } else if (selectedDay == "20") {
      return [
        timeSlotRow("09", [
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Micro", "Room 101", 'ClasshabitTask'),
          emptyBox(),
          classBox("Macro", "Room 101", 'ClassTeamTask'),
          emptyBox(),
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Org Mgt", "Room 101", 'ClassTeamTask'),
        ]),
      ];
    } else if (selectedDay == "21") {
      return [
        timeSlotRow("09", [
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Micro", "Room 101", 'ClasshabitTask'),
          emptyBox(),
        ]),
        timeSlotRow('10', [
          classBox("Macro", "Room 101", 'ClassTeamTask'),
          emptyBox(),
        ]),
      ];
    } else if (selectedDay == "22") {
      return [
        timeSlotRow("09", [
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Micro", "Room 101", 'ClasshabitTask'),
          emptyBox(),
          classBox("Macro", "Room 101", 'ClassTeamTask'),
          emptyBox(),
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Org Mgt", "Room 101", 'ClassTeamTask'),
        ]),
      ];
    } else if (selectedDay == "23") {
      return [
        timeSlotRow("09", [
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Micro", "Room 101", 'ClasshabitTask'),
          emptyBox(),
          classBox("Macro", "Room 101", 'ClassTeamTask'),
          emptyBox(),
        ]),
      ];
    } else if (selectedDay == "24") {
      return [
        timeSlotRow("09", [
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Micro", "Room 101", 'ClasshabitTask'),
          emptyBox(),
          classBox("Macro", "Room 101", 'ClassTeamTask'),
          emptyBox(),
          classBox("Financial Mgt", "Room 101", 'ClassTask'),
          classBox("Org Mgt", "Room 101", 'ClassTeamTask'),
        ]),
      ];
    }
    return [];
  }

  // دالة لعرض صف الوقت
  Widget timeSlotRow(String time, List<Widget> classes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          child:
              Text("$time AM", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...classes,
      ],
    );
  }

  // دالة لعرض الفئة الدراسية
  Widget classBox(String title, String room, String classType) {
    Color boxColor;
    switch (classType) {
      case 'ClassTask':
        boxColor = Colors.blueGrey;
        break;
      case 'ClassTaskDone':
        boxColor = Color.fromARGB(255, 114, 164, 189);
        break;
      case 'ClasshabitTask':
        boxColor = Colors.purple;
        break;
      case 'ClasshabitTaskDone':
        boxColor = Color.fromARGB(255, 182, 81, 200);
        break;
      case 'ClassTeamTask':
        boxColor = Colors.teal;
        break;
      case 'ClassTeamTaskDone':
        boxColor = Color.fromARGB(255, 5, 219, 198);
        break;
      default:
        boxColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        // عرض نافذة عند الضغط
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title: $title"),
                  Text("Room: $room"),
                  Text("Class Type: $classType"),
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق النافذة
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 140,
        width: 50,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  room,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لعرض مربع فارغ
  Widget emptyBox() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }

  // دالة لتنسيق ترويسة اليوم
  Widget dayHeader(String day, String weekday, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = day; // تحديث اليوم المحدد عند الضغط
        });
      },
      child: Column(
        children: [
          Text(
            day,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: selectedDay == day
                  ? theme.primaryColor
                  : theme.textTheme.bodyMedium?.color,
            ),
          ),
          Text(
            weekday,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: selectedDay == day ? theme.primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
