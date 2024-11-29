import 'package:flutter/material.dart';
import '../colors.dart';
import 'menuScreen.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime date = DateTime.now();
  int selectedDayIndex = 0;

  final List<String> numberOfDays = ["18", "19", "20", "21", "22", "23", "24"];
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  // بيانات الجدول الافتراضية
  final List<List<Map<String, dynamic>>> schedules = [
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": true,
        "checklist": [
          {
            "title": 'Checklist title 1',
            "completed": true,
          },
          {
            "title": 'Checklist title 2',
            "completed": true,
          },
          {
            "title": 'Checklist title 3',
            "completed": false,
          },
        ],
      },
      {
        "time": "10:10 AM",
        "title": "EC 203 - Principles of Macroeconomics",
        "room": "Room 213",
        "status": "Missing assignment",
        "assignmentMissing": true,
        "checklist": [
          {
            "title": 'Checklist title 1',
            "completed": true,
          },
          {
            "title": 'Checklist title 2',
            "completed": true,
          },
          {
            "title": 'Checklist title 3',
            "completed": false,
          },
        ]
      },
      {
        "time": "11:10 AM",
        "title": "FN 215 - Financial Management",
        "room": "Room 111",
        "status": "",
        "assignmentMissing": true,
        "checklist": [
          {
            "title": 'Checklist title 1',
            "completed": true,
          },
          {
            "title": 'Checklist title 2',
            "completed": true,
          },
        ]
      },
    ],
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": true,
        "checklist": [
          {
            "title": 'Checklist title 1',
            "completed": true,
          },
        ]
      }
    ],
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "09:10 AM",
        "title": "EC 203 - Principles of Macroeconomics",
        "room": "Room 213",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "10:10 AM",
        "title": "EC 202 - Principles of Microeconomics",
        "room": "Room 302",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "11:10 AM",
        "title": "FN 215 - Financial Management",
        "room": "Room 111",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
    ],
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "09:10 AM",
        "title": "EC 203 - Principles of Macroeconomics",
        "room": "Room 213",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "11:10 AM",
        "title": "FN 215 - Financial Management",
        "room": "Room 111",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
    ],
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "09:10 AM",
        "title": "EC 203 - Principles of Macroeconomics",
        "room": "Room 213",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "10:10 AM",
        "title": "EC 202 - Principles of Microeconomics",
        "room": "Room 302",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "11:10 AM",
        "title": "FN 215 - Financial Management",
        "room": "Room 111",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
    ],
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "09:10 AM",
        "title": "EC 203 - Principles of Macroeconomics",
        "room": "Room 213",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "11:10 AM",
        "title": "FN 215 - Financial Management",
        "room": "Room 111",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
    ],
    [
      {
        "time": "09:10 AM",
        "title": "MGT 101 - Organization Management",
        "room": "Room 101",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "09:10 AM",
        "title": "EC 203 - Principles of Macroeconomics",
        "room": "Room 213",
        "status": "Missing assignment",
        "assignmentMissing": false,
        "checklist": [],
      },
      {
        "time": "10:10 AM",
        "title": "EC 202 - Principles of Microeconomics",
        "room": "Room 302",
        "status": "",
        "assignmentMissing": false,
        "checklist": [],
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(titleTextStyle: TextStyle(
            color: AppColors.lightPrimaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans_18pt-Bold'),
        title: Text("Calendar",
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person),
          iconSize: 28,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MenuScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('icons/Icon.png', width: 30, height: 30),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // جزء التحكم بالأيام
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.colorScheme.secondary.withOpacity(0.2),
            ),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  onPressed: () async {
                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2060),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: theme.primaryColor,
                              onPrimary: Colors.white,
                              surface: theme.cardColor,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                  foregroundColor: theme.primaryColor),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (d != null) {
                      setState(() {
                        date = d;
                      });
                    }
                  },
                  child: Text(
                    "${date.day}/${date.month}/${date.year}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDaySelector(theme),
              ],
            ),
          ),
          // عرض الجدول اليومي
          Expanded(
            child: ListView.builder(
              itemCount: schedules[selectedDayIndex].length,
              itemBuilder: (context, index) {
                final item = schedules[selectedDayIndex][index];
                List<ChecklistItem> checklistItems = item['checklist']
                        ?.map<ChecklistItem>((check) => ChecklistItem(
                              title: check['title'],
                              isChecked: check['completed'],
                            ))
                        ?.toList() ??
                    [];

                return TaskItem(
                  time: item["time"] ?? "",
                  title: item["title"] ?? "",
                  room: item["room"] ?? "",
                  statue: item["statue"] ?? "",
                  checklistItems: checklistItems,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector(ThemeData theme) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final isSelected = selectedDayIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDayIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.primaryColor
                    : theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    numberOfDays[index],
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    days[index],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String time;
  final String title;
  final String room;
  final String statue;
  final List<ChecklistItem> checklistItems;

  TaskItem({
    required this.time,
    required this.title,
    required this.room,
    required this.statue,
    required this.checklistItems,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController _controller = TextEditingController();

  void _addChecklistItem(String title) {
    setState(() {
      widget.checklistItems.add(ChecklistItem(title: title, isChecked: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.time, style: theme.textTheme.titleSmall),
            Text(widget.title,
                style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.primaryColor, fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Text(widget.room, style: theme.textTheme.bodySmall),
        children: [
          ...widget.checklistItems.map((item) {
            return CheckboxListTile(
              activeColor: theme.primaryColor,
              title: Text(item.title),
              value: item.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  item.isChecked = value ?? false;
                });
              },
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Checklist Item"),
                      content: TextField(
                        controller: _controller,
                        decoration:
                            InputDecoration(hintText: "Enter task name"),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              _addChecklistItem(_controller.text);
                              _controller.clear();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Add"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                "Assignments",
                style: TextStyle(color: Colors.white),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class ChecklistItem {
  final String title;
  bool isChecked;

  ChecklistItem({
    required this.title,
    this.isChecked = false,
  });
}
