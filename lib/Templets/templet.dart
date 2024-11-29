import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../BottomNavBar/bottomNavBar.dart';
// قم باستيراد UiProvider

class TemplatesScreen extends StatefulWidget {
  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  final List<String> templates = [
    'Instructional Template',
    'Educational Template',
    'Professional Template',
    'Default',
  ];
  final List<String> description = [
    'A framework for organizing and delivering education, based on various teaching philosophies.',
    'Focuses on teaching methods and lesson design to effectively engage students and assess learning.',
    'Standards and practices in a profession, guiding skills and behaviors for success in the workplace.',
    'Default page description.',
  ];

  final List<String> models = [
    '8 _ 8 _ 8',
    '6 _ 6 _ 6 _ 6',
  ];

  final List<String> modelDescriptions = [
    'The 8-8-8 learning system splits the day into three parts: 8 hours for learning, 8 hours for application, and 8 hours for rest.',
    'The 6-6-6-6 system divides the day into four 6-hour segments: Study, Application, Relaxation, Sleep.',
  ];

  final List<String> modelImages = [
    'images/schedule.png',
    'images/schedule.png',
  ];

  int? selectedIndex; // مؤشر الحاوية المختارة
  String? selectedModel; // النموذج الذي اختاره المستخدم
  String? selectedImage;

  /// التعامل مع النقر على الحاوية
  void onContainerTap(BuildContext context, int index) {
    setState(() {
      selectedIndex = index; // تحديث الحاوية المختارة
    });

    if (index < templates.length) {
      final template = templates[index];

      if (template == 'Default') {
      } else {
        showModelSelectionDialog(context, template);
      }
    }
  }

  /// نافذة اختيار النموذج
  void showModelSelectionDialog(BuildContext context, String templateName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: DefaultTabController(
            length: models.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Select Model for $templateName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: models.map((model) => Tab(text: model)).toList(),
                ),
                Container(
                  height: 200, // ارتفاع محتوى التبويب
                  child: TabBarView(
                    children: models.map((model) {
                      final index = models.indexOf(model);
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              model,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              modelDescriptions[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  selectedModel = model;
                                  // تخزين النموذج المختار
                                });

                                showModelDetails(
                                    context, model, modelImages[index]);
                              },
                              child: Text('Select'),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showModelDetails(BuildContext context, String model, String image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    model,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(image),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'))
              ],
            ),
          );
        });
  }

  /// الانتقال إلى صفحة جديدة
  void navigateToNewPage() {
    if (selectedIndex != null && selectedModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bottomnavbar(selectedModel: selectedModel!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentTheme =
        uiProvider.isDark ? uiProvider.darkTheme : uiProvider.lightTheme;

    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'TEMPLATES',
            style: currentTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose your best template',
            style: TextStyle(
              color: currentTheme.textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () => onContainerTap(context, index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? currentTheme.cardColor
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? currentTheme.primaryColor
                              : Colors.white30,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              templates[index],
                              style: currentTheme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: currentTheme.textTheme.bodyLarge?.color,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              description[index],
                              textAlign: TextAlign.center,
                              style:
                                  currentTheme.textTheme.bodyMedium?.copyWith(
                                color: currentTheme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 170,
              child: ElevatedButton(
                onPressed: (selectedIndex != null && selectedModel != null)
                    ? navigateToNewPage
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      (selectedIndex != null && selectedModel != null)
                          ? currentTheme.primaryColor
                          : currentTheme.primaryColor.withOpacity(0.3),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Center(
                  child: Text(
                    'ADD',
                    style: currentTheme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
