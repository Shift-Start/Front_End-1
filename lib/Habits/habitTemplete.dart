import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomeScreen/menuScreen.dart';
import 'addHabits.dart';
import 'editTemplete.dart';

// تأكد من استيراد الملف الذي يحتوي على AppColors و UiProvider

class HabitsTemplateScreen extends StatefulWidget {
  @override
  _HabitsTemplateScreenState createState() => _HabitsTemplateScreenState();
}

class _HabitsTemplateScreenState extends State<HabitsTemplateScreen> {
  // تعريف قائمة العادات
  final List<Map<String, dynamic>> habits = [
    {
      'title': 'Read',
      'iconPath': 'icons/icons8-read-80.png',
      'color': AppColors.lightCard, // استخدام الألوان من AppColors
      'page': EditTemplateScreen(),
    },
    {
      'title': 'Reserve',
      'iconPath': 'icons/icons8-money-bag-40.png',
      'color': AppColors.lightCard,
      'page': EditTemplateScreen(),
    },
    {
      'title': 'Education',
      'iconPath': 'icons/icons8-graduation-cap-50.png',
      'color': AppColors.lightCard,
      'page':EditTemplateScreen(),
    },
    {
      'title': 'Programming',
      'iconPath': 'icons/icons8-program-48.png',
      'color': AppColors.lightCard,
      'page': EditTemplateScreen(),
    },
    {
      'title': 'Health',
      'iconPath': 'icons/icons8-trust-64.png',
      'color': AppColors.lightCard,
      'page': EditTemplateScreen(),
    },
    {
      'title': 'New',
      'iconPath': 'icons/icons8-add-to-favorites-64.png',
      'color': AppColors.lightCard,
      'page': AddHabitsPage(),
    },
  ];

  // هذه الخريطة لتخزين الحالة (اللون) الحالي لكل عنصر عند الضغط
  Map<int, Color> selectedColors = {};

  @override
  Widget build(BuildContext context) {
    // الحصول على السمة الحالية من UiProvider
    final isDark = Provider.of<UiProvider>(context).isDark;
    final theme = isDark
        ? Provider.of<UiProvider>(context).darkTheme
        : Provider.of<UiProvider>(context).lightTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MenuScreen()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("Habits Templates"),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: theme.textTheme.bodyLarge!.color,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: theme.iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];

            // التحقق من حالة اللون الحالي للمستطيل
            Color currentColor = selectedColors[index] ?? habit['color'];

            return GestureDetector(
              onTap: () {
                // تغيير اللون عند الضغط
                setState(() {
                  // إذا كان اللون قد تغير مسبقاً، قم بإعادته إلى اللون الأساسي
                  if (selectedColors.containsKey(index) &&
                      selectedColors[index] == habit['color']) {
                    selectedColors.remove(index);
                  } else {
                    selectedColors[index] =
                        theme.primaryColor; // تغيير اللون عند الضغط
                  }
                });

                // الانتقال إلى الصفحة المرتبطة بـ Container
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => habit['page']),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: currentColor, // استخدام اللون المحدد
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    habit['iconPath'] != null
                        ? Image.asset(
                            habit['iconPath'],
                            width: 40,
                            height: 40,
                          )
                        : Icon(
                            habit['icon'],
                            size: 40,
                            color: theme.iconTheme.color,
                          ),
                    SizedBox(height: 8),
                    Text(
                      habit['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge!.color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
