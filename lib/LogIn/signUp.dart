import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';

import 'forgetPassword.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final theme =
        uiProvider.isDark ? uiProvider.darkTheme : uiProvider.lightTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title
            Center(
              child: Container(
                width: 290,
                height: 39,
                margin: const EdgeInsets.only(top: 40),
                child: Text(
                  'Create an Account',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'DMSans_18pt-Bold',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Subtitle
            Center(
              child: Container(
                width: 291,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'DMSans-Italic-VariableFont_opsz,wght',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Full Name Input
            _buildInputField(
              theme: theme,
              label: 'Full name',
              hintText: 'Enter Your Name',
            ),
            const SizedBox(height: 10),

            // Email Input
            _buildInputField(
              theme: theme,
              label: 'Email',
              hintText: 'Enter Your Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),

            // Password Input
            _buildInputField(
              theme: theme,
              label: 'Password',
              hintText: 'Enter Your Password',
              obscureText: true,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 10),

            // Checkbox and Forgot Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: check,
                        onChanged: (val) {
                          setState(() {
                            check = val!;
                          });
                        },
                      ),
                      Text(
                        'Remember me',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Forgetpassword()));
                    },
                    child: Text(
                      'Forget password?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: () {
                    // Handle login
                  },
                  child: Text(
                    'LOGIN',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Google Sign In Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: () {
                    // Handle Google Sign-In
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/google.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'SIGN IN WITH GOOGLE',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Signup Redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You don\'t have an account yet? ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Forgetpassword()));
                  },
                  child: Text(
                    'Sign In',
                    style: theme.textTheme.bodyMedium?.copyWith(
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
      ),
    );
  }

  Widget _buildInputField({
    required ThemeData theme,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: theme.inputDecorationTheme.hintStyle,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
