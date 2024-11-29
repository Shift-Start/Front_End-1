import 'package:ShiftStart/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Templets/templet.dart';
import 'login.dart';

class Successfully extends StatefulWidget {
  const Successfully({super.key});

  @override
  State<Successfully> createState() => _SuccessfullyState();
}

class _SuccessfullyState extends State<Successfully> {
  @override
  Widget build(BuildContext context) {
    // استدعاء UiProvider للحصول على الثيم الحالي (فاتح/داكن)
    final uiProvider = Provider.of<UiProvider>(context);
    final isDark = uiProvider.isDark; // التحقق إذا كان الوضع داكنًا
    final theme =
        isDark ? uiProvider.darkTheme : uiProvider.lightTheme; // الثيم الحالي

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // العنوان الرئيسي
              Text(
                'Successfully',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'DMSans_18pt-Bold',
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 12),

              // النص الثانوي
              Text(
                'Your password has been updated. Please change your password regularly to avoid this happening.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 50),

              // الصورة
              Image.asset(
                'images/successfully.png',
                fit: BoxFit.contain,
                width: 150,
              ),
              const SizedBox(height: 70),

              // زر متابعة
              SizedBox(
               width: 300,
                  height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor, // اللون الأساسي للزر
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => TemplatesScreen()),
                    );
                  },
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary, // لون النص داخل الزر
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'DMSans_18pt-Bold',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // زر العودة لتسجيل الدخول
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.cardColor, // لون الكرت (لون ثانوي)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    'BACK TO LOGIN',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary, // لون النص داخل الزر
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'DMSans_18pt-Bold',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
