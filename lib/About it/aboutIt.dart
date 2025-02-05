import 'package:ShiftStart/BottomNavBar/bottomNavBar.dart';
import 'package:ShiftStart/Templets/templet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Replace with the actual home screen file
import '../colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding pages data
  final List<Map<String, String>> _pages = [
    {
      "title": "Habit Management",
      "description": "Add your daily habits and track your progress easily!",
      "image": "images/habit.webp"
    },
    {
      "title": "Task Organization",
      "description":
          "Create a schedule to efficiently manage your daily tasks.",
      "image": "images/task.webp"
    },
    {
      "title": "Team Collaboration",
      "description": "Create your own team and communicate via chat!",
      "image": "images/team.webp"
    },
  ];

  // Save onboarding completion status
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TemplatesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<UiProvider>(context).isDark
        ? Provider.of<UiProvider>(context).darkTheme
        : Provider.of<UiProvider>(context).lightTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_pages[index]["image"]!, height: 250),
                      const SizedBox(height: 30),
                      Text(
                        _pages[index]["title"]!,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _pages[index]["description"]!,
                        textAlign: TextAlign.center,
                        style:
                            theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Progress indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index ? theme.primaryColor : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage != _pages.length - 1)
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text("Skip",
                        style:
                            TextStyle(fontSize: 16, color: theme.primaryColor)),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(120, 50),
                  ),
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                      _currentPage == _pages.length - 1
                          ? "Get Started"
                          : "Next",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
