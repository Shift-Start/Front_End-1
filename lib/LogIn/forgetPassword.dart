import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'check your email.dart';
import 'login.dart';
 

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
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
          // عنوان الصفحة
          Center(
            child: Container(
              width: 290,
              height: 39,
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Forget Password',
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
                  Text(
                    'To reset your password, you need your email or mobile number that can be authenticated',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                        fontSize: 12,
                        color: theme.textTheme.bodyMedium!.color),
                  ),
                ],
              ),
            ),
          ),
          // الصورة
          SizedBox(height: 30),
          Container(
            width: 100,
            height: 100,
            child: Center(
              child: Image(image: AssetImage('images/forget1.png')),
            ),
          ),
          SizedBox(height: 40),
          // إدخال البريد الإلكتروني
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 400, bottom: 10),
                child: Text(
                  'Email',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium!.color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Email',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          // زر إعادة تعيين كلمة المرور
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                   backgroundColor: theme.primaryColor, // استخدام اللون الأساسي من الثيم
                    padding: EdgeInsets.symmetric(vertical: 20),
                    minimumSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckEmail()));
                  },
                  child: Text(
                    'RESET PASSWORD',
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
          // زر العودة لتسجيل الدخول
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.cardColor, // استخدام لون الكارت من الثيم
                    padding: EdgeInsets.symmetric(vertical: 20),
                    minimumSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Login()));
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
        ],
     ),
);
}
}
