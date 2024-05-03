import 'package:cloud_firestore/cloud_firestore.dart';

int durationFromData(Timestamp startTime, Timestamp endTime) {
  return endTime.toDate().difference(startTime.toDate()).inDays+1;
}