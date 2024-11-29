import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'login.dart';
import 'successfully.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({super.key});

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  Widget build(BuildContext context) {
    // الحصول على الثيم من الـ UiProvider
    final uiProvider = Provider.of<UiProvider>(context);
    final isDark = uiProvider.isDark;

    // اختيار الثيم بناءً على الوضع الداكن أو الفاتح
    ThemeData theme = isDark ? uiProvider.darkTheme : uiProvider.lightTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // استخدام خلفية الثيم

      body: Column(
        children: [
          Center(
            child: Container(
              width: 290,
              height: 39,
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Check Your Email',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'DMSans_18pt-Bold',
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          // النص التوضيحي
          Center(
            child: Container(
              width: 291,
              height: 38,
              child: Column(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'We have sent the reset password to the email address ',
                            style: TextStyle(
                                fontFamily:
                                    'DMSans-Italic-VariableFont_opsz,wght',
                                fontSize: 12,
                                color: theme.textTheme.bodyMedium!.color),
                          ),
                          TextSpan(
                            text: 'brandonelouis@gmail.com',
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium!.color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DMSans_18pt-Bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // الصورة
          SizedBox(height: 50),
          Center(
            child: Image.asset('images/check.png'),
          ),
          SizedBox(height: 70),
          // زر فتح البريد الإلكتروني
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        theme.primaryColor, // استخدام اللون الأساسي من الثيم
                    padding: EdgeInsets.symmetric(vertical: 20),
                    minimumSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'OPEN YOUR EMAIL',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'DMSans_18pt-Bold',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // زر العودة لتسجيل الدخول
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        theme.cardColor, // استخدام لون الكارت من الثيم
                    padding: EdgeInsets.symmetric(vertical: 20),
                    minimumSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'BACK TO LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'DMSans_18pt-Bold',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // إعادة إرسال البريد الإلكتروني
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have not received the email? ',
                style: TextStyle(
                  fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                  color: theme.textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Successfully()));
                },
                child: Text(
                  ' Resend',
                  style: TextStyle(
                    fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                    decoration: TextDecoration.underline,
                    decorationColor: theme.primaryColor,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
