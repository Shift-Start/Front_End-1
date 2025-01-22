import 'package:flutter/material.dart';

class Team {
  String name;
  String scope;
  String description;
  List<Member> members;
  List<Task> tasks;

  Team(
      {required this.name,
      required this.scope,
      required this.description,
      required this.members,
      required this.tasks});
}

class Task {
  String title;
  String? assignedTo;
  String description;
  String status;
  DateTime? startTime;
  DateTime? endTime;
  Task(
      {required this.title,
      this.assignedTo,
      required this.description,
      this.status = 'Unassigned',required this.endTime,required this.startTime});
}

class Member {
  String name;
  String role;
  Member({required this.name, required this.role});
}

class TeamProvider extends ChangeNotifier {
  List<Team> _teams = [];
  List<Team> get teams => _teams;

  void addTeam(Team team) {
    _teams.add(team);
    notifyListeners();
  }

  void removeTeam(int index) {
    _teams.removeAt(index);
    notifyListeners();
  }

  // تعديل بيانات الفريق
  void updateTeam(int index, Team updatedTeam) {
    _teams[index] = updatedTeam;
    notifyListeners();
  }

  void addMember(int teamIndex, Member member) {
    _teams[teamIndex].members.add(member);
    notifyListeners();
  }

  void removeMember(int teamIndex, int memberIndex) {
    _teams[teamIndex].members.removeAt(memberIndex);
    notifyListeners();
  }

  void updateMember(int teamIndex, int memberIndex) {
    _teams[teamIndex].members[memberIndex];
    notifyListeners();
  }

  void addTask(int teamIndex, Task task) {
    _teams[teamIndex].tasks.add(task);
    notifyListeners();
  }

  void removeTask(int teamIndex, int taskIndex) {
    _teams[teamIndex].tasks.removeAt(taskIndex);
    notifyListeners();
  }

  void assignTask(int teamIndex, int taskIndex, String memberId) {
    teams[teamIndex].tasks[taskIndex].assignedTo = memberId;
    teams[teamIndex].tasks[taskIndex].status = 'Assigned';
    notifyListeners();
  }

  void updateTask(int teamIndex, int taskIndex, Task updatedTask) {
    _teams[teamIndex].tasks[taskIndex] = updatedTask;
    notifyListeners();
  }

  List<Task> getUnassignedTasks(int teamIndex) {
    return _teams[teamIndex]
        .tasks
        .where((task) => task.assignedTo == null)
        .toList();
  }

  List<Task> getMemberTasks(String memberName) {
    List<Task> memberTasks = [];
    for (var team in _teams) {
      memberTasks
          .addAll(team.tasks.where((task) => task.assignedTo == memberName));
    }
    return memberTasks;
  }
}
