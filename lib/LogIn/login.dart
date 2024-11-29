import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'signUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check = false;

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
              margin: EdgeInsets.only(top: 40),
              width: 240,
              height: 39,
              child: Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    fontFamily: 'DMSans_18pt-Bold'),
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
                    'Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                        fontSize: 12,
                        color: theme.textTheme.bodyMedium!.color),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
          // إدخال البريد الإلكتروني
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 390, bottom: 10),
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
                      borderRadius: BorderRadius.circular(16)),
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
          SizedBox(height: 10),
          // إدخال كلمة المرور
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 370, bottom: 10),
                child: Text(
                  'Password',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium!.color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility_off),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Your Password',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // تذكرني وكلمة المرور
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                  value: check,
                  onChanged: (val) {
                    setState(() {
                      check = val!;
                    });
                  }),
              Container(
                margin: EdgeInsets.only(right: 240),
                child: Text(
                  'Remember me',
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                      color: theme.textTheme.bodyMedium!.color,
                      fontSize: 12),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(
                    'Forget password?',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                        fontSize: 16,
                        color: theme.textTheme.bodyMedium!.color),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          // زر تسجيل الدخول
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
                  onPressed: () {
                    // تسجيل الدخول
                  },
                  child: Text(
                    'LOGIN',
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

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.cardColor,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 25,
                          height: 23,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/google.png'))),
                        ),
                        Text(
                          'SIGN IN WITH GOOGLE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
          SizedBox(height: 15),
          // روابط إنشاء حساب
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You dont have an account yet? ',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                    fontWeight: FontWeight.bold,
                  )),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text(
                  ' Sign Up ',
                  style: theme.textTheme.bodyMedium!.copyWith(
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
