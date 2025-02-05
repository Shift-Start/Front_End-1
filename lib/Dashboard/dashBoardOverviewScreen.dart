import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
 

import 'themeColor.dart';
import 'usersManagement.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Overview"),
        backgroundColor: AppColors.lightButton, // استخدام اللون من الثيم
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall Statistics",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.lightPrimaryText, // تغيير اللون
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                DashboardCard(title: "Users", value: "120"),
                DashboardCard(title: "Active Teams", value: "8"),
                DashboardCard(title: "Used Templates", value: "25"),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              "Monthly Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.lightPrimaryText, // تغيير اللون
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: ActivityChart()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Users Management
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersManagement()),
                );
              },
              child: const Text("Go to User Management"),
              style: ElevatedButton.styleFrom(
             backgroundColor: AppColors.lightButton, // تغيير اللون للزر
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.lightCard, // تغيير لون البطاقة
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.lightPrimaryText, // اللون عند عرض العنوان
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.lightPrimaryText, // تغيير اللون للنص
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityChart extends StatelessWidget {
  const ActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true, border: Border.all(color: AppColors.lightPrimaryText)), // لون الحدود
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(1, 5),
              const FlSpot(2, 3),
              const FlSpot(3, 8),
              const FlSpot(4, 6),
              const FlSpot(5, 10),
            ],
            isCurved: true,
            color: AppColors.lightButton, // تغيير اللون للخط
            barWidth: 4,
            isStrokeCapRound: true,
          ),
        ],
     ),
);
}
}
