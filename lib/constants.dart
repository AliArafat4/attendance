import 'package:attendance/view/login.dart';
import 'package:attendance/view/attendance.dart';
import 'package:attendance/view/home_screen.dart';
import 'package:attendance/view/members.dart';
import 'package:attendance/view/selectFile_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomeScreen(),
  '/members': (context) => const Members(),
  '/attendance': (context) => const Attendance(),
  '/login': (context) => const LoginScreen(),
  '/selectFile': (context) => const SelectFileScreen(),
};
