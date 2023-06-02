import 'package:attendance/view/attendance.dart';
import 'package:attendance/view/home_screen.dart';
import 'package:attendance/view/members.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomeScreen(),
  '/members': (context) => const Members(),
  '/attendance': (context) => const Attendance(),
};

//TODO: change to data from excel
List<int> sn = [1, 2, 3, 4];
List<String> names = [
  "Ali Hussain Arafat",
  "Ahmed",
  "Mohammed Abdullah almohammed",
  "Hadi"
];
List<String> phone = ["1234567890", "8888888888", "1234567890", "1234567890"];
List<bool> isAttend = [true, true, false, true];
