import 'package:flutter/material.dart';

import '../HomeScreen/menuScreen.dart';
import '../colors.dart';
import 'habitTemplete.dart';
import 'templeteList.dart';

class EditTemplateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // ThemeData الخاص بالتطبيق

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: AppColors.lightPrimaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans_18pt-Bold'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HabitsTemplateScreen()));
            },
            icon: Icon(Icons.arrow_back,
                color: theme.iconTheme.color)), // إخفاء زر الرجوع الافتراضي
        title: Text(
          'Edit Templates',
          // style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: theme.iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop(); // غلق الواجهة الحالية
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Habit name TextField
            _buildField(
              context,
              label: 'Habit name',
              hint: 'Enter habit name',
            ),

            SizedBox(height: 16.0),

            // Goal TextField
            _buildField(
              context,
              label: 'Goal',
              hint: 'Enter goal',
            ),

            SizedBox(height: 16.0),

            // Start date and End date
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    context,
                    label: 'Start date',
                    hint: 'DD/MM/YYYY',
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _buildField(
                context,
                label: 'End date',
                hint: 'DD/MM/YYYY',
              ),
            ),

            SizedBox(height: 16.0),

            // Description TextField
            _buildField(context,
                label: 'Description',
                hint: 'Write additional information here',
                maxLines: 4),

            SizedBox(height: 32.0),

            // Buttons: REMOVE and SAVE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // مسح كل الحقول
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Remove'),
                        content:
                            Text('Are you sure you want to remove all fields?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // إعادة ضبط النصوص أو أي منطق مرتبط
                              Navigator.of(context).pop();
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        theme.colorScheme.secondary, // لون زر REMOVE
                  ),
                  child: Text(
                    'REMOVE',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // الانتقال إلى واجهة جديدة
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Templetelist(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor, // لون زر SAVE
                  ),
                  child: Text(
                    'SAVE',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildField(BuildContext context,
    {required String label, required String hint, int maxLines = 1}) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: theme.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
    ],
  );
}
