import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import 'editTemplete.dart';
import 'habitTemplete.dart';
import 'templeteList.dart';

class AddHabitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Theme to get current colors and styles

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
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Add Habits',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.primaryColor,
        iconTheme: theme.iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Habit Name Field
            _buildField(
              context,
              label: 'Habit name',
              hint: 'Enter habit name',
            ),
            const SizedBox(height: 16), // Spacing between fields

            // Goal Field
            _buildField(
              context,
              label: 'Goal',
              hint: 'Enter your goal',
            ),
            const SizedBox(height: 16),

            // Start and End Date Fields
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    context,
                    label: 'Start date',
                    hint: 'Enter start date',
                  ),
                ),
                const SizedBox(width: 8), // Space between the two fields
                Expanded(
                  child: _buildField(
                    context,
                    label: 'End date',
                    hint: 'Enter end date',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description Field
            _buildField(
              context,
              label: 'Description',
              hint: 'Write additional information here',
              maxLines: 4,
            ),
            const Spacer(),

            // Save Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Navigate to another page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Templetelist(),
                      ),
                    );
                  },
                  child: Text(
                    'SAVE',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to Build Each Field (Label + TextField)
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
}
