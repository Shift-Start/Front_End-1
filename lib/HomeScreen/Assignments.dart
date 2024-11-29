import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'menuScreen.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  // Variables for checkbox states
  bool checklist1 = true;
  bool checklist2 = true;
  bool checklist3 = false;
  bool checklist4 = false;
  bool checklist5 = false;
  String selectedTab = 'Due Date';

  // Variables for edit state
  List<bool> isEditingList = [
    false,
    false,
    false
  ]; // To track if we are in edit mode
  List<TextEditingController> titleControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: AppColors.lightPrimaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans_18pt-Bold'),
        title: Text(
          'Assignments',
          //  style: theme.textTheme.bodyLarge?.copyWith(
          //fontWeight: FontWeight.bold,
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: theme.scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTabItem('Due Date'),
                buildTabItem('Classes'),
                buildTabItem('Priority'),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          if (selectedTab == 'Due Date') ...[
            // Section for Today's assignments
            Text(
              'Today - October 18th, 2023',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            buildAssignmentItem(
              'MGT 101 - Organization Management',
              checklistItems: [
                ChecklistItem(
                  title: 'Checklist title 1',
                  note: 'Note from checklist',
                  value: checklist1,
                  onChanged: (value) {
                    setState(() {
                      checklist1 = value!;
                    });
                  },
                ),
                ChecklistItem(
                  title: 'Checklist title 2',
                  note: 'Note from checklist',
                  value: checklist2,
                  onChanged: (value) {
                    setState(() {
                      checklist2 = value!;
                    });
                  },
                ),
                ChecklistItem(
                  title: 'Checklist title 3',
                  note: 'Note from checklist',
                  value: checklist3,
                  onChanged: (value) {
                    setState(() {
                      checklist3 = value!;
                    });
                  },
                ),
              ],
              index: 0,
            ),
            Divider(thickness: 1.0),
            buildAssignmentItem('EC 203 - Principles Macroeconomics',
                checklistItems: [
                  ChecklistItem(
                    title: 'Checklist title 4',
                    note: 'Note from checklist',
                    value: checklist4,
                    onChanged: (value) {
                      setState(() {
                        checklist4 = value!;
                      });
                    },
                  ),
                ],
                index: 1),
            SizedBox(height: 20),

            // Section for Tomorrow's assignments
            Text(
              'Tomorrow - October 18th, 2023',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            buildAssignmentItem(
              'FN 215 - Financial Management',
              checklistItems: [
                ChecklistItem(
                  title: 'Checklist title 5',
                  note: 'Note from checklist',
                  value: checklist5,
                  onChanged: (value) {
                    setState(() {
                      checklist5 = value!;
                    });
                  },
                ),
              ],
              index: 2,
            ),
          ],
        ]),
      ),
    );
  }

  Widget buildTabItem(String tabName) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabName;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color:
              selectedTab == tabName ? theme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          tabName,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: selectedTab == tabName ? Colors.white : theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildAssignmentItem(String title,
      {required List<ChecklistItem> checklistItems, required int index}) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // If editing, show TextField, otherwise show Text
            isEditingList[index]
                ? Expanded(
                    child: TextField(
                      controller: titleControllers[index]
                        ..text = title, // Set initial text
                      decoration:
                          InputDecoration(border: UnderlineInputBorder()),
                      onChanged: (text) {
                        setState(() {
                          titleControllers[index].text = text;
                        });
                      },
                    ),
                  )
                : Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: title.contains('MGT')
                          ? theme.colorScheme.secondary
                          : title.contains('EC')
                              ? theme.colorScheme.primary
                              : theme.primaryColor,
                    ),
                  ),
            isEditingList[index]
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Save the edited title here
                        title = titleControllers[index].text;
                        isEditingList[index] =
                            false; // Switch back to normal mode
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor, // Button color
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : IconButton(
                    icon: Icon(Icons.edit, color: theme.iconTheme.color),
                    onPressed: () {
                      setState(() {
                        isEditingList[index] = true; // Switch to edit mode
                      });
                    },
                  ),
          ],
        ),
        SizedBox(height: 5),
        ...checklistItems,
      ],
    );
  }
}

class ChecklistItem extends StatelessWidget {
  final String title;
  final String note;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ChecklistItem({
    required this.title,
    required this.note,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: theme.iconTheme.color,
          activeColor: theme.primaryColor,
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: value
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  note,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                    decoration: value
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
