import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/Model/task.dart';
import 'package:flutter_app_to_do/firebase_utils.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter (select date)
    tasksList = tasksList.where((task) {
      if (task.dateTime!.day == selectDate.day &&
          task.dateTime!.month == selectDate.month &&
          task.dateTime!.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();
    //// sorting orderBy()
    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });
    notifyListeners();
  }

  void changeData(DateTime newData, String uId) {
    selectDate = newData;
    getAllTasksFromFireStore(uId);
  }
}
