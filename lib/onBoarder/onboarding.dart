import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../LogIn/login.dart';
import '../colors.dart';
// تعديل مسار UiProvider حسب مكان الملف

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<UiProvider>(context).isDark
        ? Provider.of<UiProvider>(context).darkTheme
        : Provider.of<UiProvider>(context).lightTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        backgroundColor: theme.primaryColor,
        child: Icon(
          Icons.arrow_forward,
          size: 30,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ShiftStart',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 311,
            height: 301,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/human.png'),
              ),
              // color: theme.cardColor.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 240),
                  child: Text(
                    'Start Your',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Dream Life',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 35,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.primaryColor,
                    color: theme.primaryColor,
                  ),
                ),
                Text(
                  'Here!',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
