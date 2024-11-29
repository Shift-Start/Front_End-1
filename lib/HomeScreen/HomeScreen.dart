import 'package:ShiftStart/Profile/setting.dart';
import 'package:flutter/material.dart';

import '../LogIn/login.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(theme),
            const SizedBox(height: 20),
            _buildActionCard(theme),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Ratings',
                style: textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildRatingsSection(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 26,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.share_outlined, color: colorScheme.onPrimary),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.settings_outlined,
                      color: colorScheme.onPrimary),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SettingsScreen(onThemeChange: (ThemeMode) {}),
                    ));
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/Mask.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  "Ibrahim Sa",
                  style: textTheme.titleMedium
                      ?.copyWith(color: colorScheme.onPrimary),
                ),
                Text(
                  "Damascus, SY",
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onPrimary),
                ),
                const SizedBox(height: 20),
                Text(
                  "1-Task (To do)",
                  style: textTheme.titleSmall
                      ?.copyWith(color: colorScheme.onPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Start making your dream come true now!!',
                    style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    isPressed
                        ? 'icons/icons8-bookmark-50.png'
                        : 'icons/icons8-bookmark_border.png',
                    height: 30,
                    color: isPressed
                        ? colorScheme.secondary
                        : colorScheme.onSurface,
                  ),
                  onPressed: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton("Create Schedule", colorScheme),
                _buildActionButton("Later", colorScheme),
                _buildActionButton("Start", colorScheme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, ColorScheme colorScheme) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  Widget _buildRatingsSection(ColorScheme colorScheme) {
    return Row(
      children: [
        _buildRatingBox(colorScheme.primaryContainer),
        const SizedBox(width: 20),
        Column(
          children: [
            _buildRatingBox(colorScheme.secondaryContainer, height: 80),
            const SizedBox(height: 20),
            _buildRatingBox(colorScheme.tertiaryContainer, height: 80),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingBox(Color color, {double height = 180}) {
    return Container(
      width: 150,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
