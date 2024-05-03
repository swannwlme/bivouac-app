import 'package:cloud_firestore/cloud_firestore.dart';

int durationFromData(Timestamp startTime, Timestamp endTime) {
  return endTime.toDate().difference(startTime.toDate()).inDays+1;
}

String dateToString(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  return "$day/$month/$year";
}