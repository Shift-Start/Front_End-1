import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

import 'leaderBoardProvider.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProvider>(context);
    final isDark = themeProvider.isDark;
    final provider = Provider.of<LeaderboardProvider>(context);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Text("Leaderboard", style: TextStyle(color: Colors.white)),
        backgroundColor: isDark ? AppColors.darkButton : AppColors.lightButton,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round,
                color: Colors.white),
            onPressed: () => themeProvider.changeTheme(),
          ),
        ],
      ),
      body: Consumer<LeaderboardProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: provider.competitors.length,
            itemBuilder: (context, index) {
              final competitor = provider.competitors[index];
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: _buildCompetitorTile(
                    context, competitor, index + 1, isDark),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCompetitorTile(
      BuildContext context, Competitor competitor, int rank, bool isDark) {
    return Card(
      color: isDark ? AppColors.darkCard : AppColors.lightCard,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            backgroundImage: competitor.imageUrl.startsWith('http')
                ? NetworkImage(competitor.imageUrl) as ImageProvider
                : AssetImage(competitor.imageUrl)),
        title: Text(
          competitor.name,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.darkPrimaryText
                  : AppColors.lightPrimaryText),
        ),
        subtitle: Text(
          "Points: ${competitor.points}",
          style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.darkSecondaryText
                  : AppColors.lightSecondaryText),
        ),
        trailing: _buildTrophy(rank),
      ),
    );
  }

  Widget _buildTrophy(int rank) {
    String trophyText;
    Color trophyColor;

    switch (rank) {
      case 1:
        trophyText = "1st Place";
        trophyColor = Colors.amber;
        break;
      case 2:
        trophyText = "2nd Place";
        trophyColor = Colors.grey;
        break;
      case 3:
        trophyText = "3rd Place";
        trophyColor = Colors.brown;
        break;
      default:
        trophyText = "$rank Place";
        trophyColor = Colors.blueGrey;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.emoji_events, color: trophyColor, size: 30),
        Text(
          trophyText,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: trophyColor),
        ),
      ],
    );
  }
}
