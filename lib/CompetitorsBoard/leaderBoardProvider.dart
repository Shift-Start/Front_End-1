import 'package:flutter/material.dart';

class Competitor {
  String name;
  int points;
  String imageUrl;

  Competitor(
      {required this.name, required this.points, required this.imageUrl});
}

class LeaderboardProvider extends ChangeNotifier {
  List<Competitor> _competitors = [
    Competitor(name: "Leen", points: 2500, imageUrl: "images/avatar.jpg"),
    Competitor(name: "Sara", points: 2300, imageUrl: "images/avatar1.jpeg"),
    Competitor(name: "Ayla", points: 2100, imageUrl: "images/avatar2.jpeg"),
    Competitor(name: "Adam", points: 1800, imageUrl: "images/avatar3.jpeg"),
  ];

  List<Competitor> get competitors => _sortedCompetitors();

  List<Competitor> _sortedCompetitors() {
    List<Competitor> sortedList = List.from(_competitors);
    sortedList.sort((a, b) => b.points.compareTo(a.points));
    return sortedList;
  }

  void updatePoints(String name, int newPoints) {
    int index = _competitors.indexWhere((c) => c.name == name);
    if (index != -1) {
      _competitors[index].points = newPoints;
      notifyListeners();
    }
  }
}
