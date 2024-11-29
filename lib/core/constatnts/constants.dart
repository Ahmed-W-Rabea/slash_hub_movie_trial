import 'package:flutter/material.dart';

const appBackgroundColor = Color(0xFF1c1c27);
const grey = Color.fromARGB(255, 26, 26, 28);
const buttonColor = Color.fromARGB(255, 85, 58, 64);

// for time

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String digitHours = duration.inHours.remainder(60).toString();
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return "${digitHours}h ${twoDigitMinutes}m";
}
