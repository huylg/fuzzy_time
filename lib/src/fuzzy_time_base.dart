import 'package:flutter/material.dart';

TimeOfDay? fuzzyTimeParse(String input) {
  if (input.isEmpty) return null;

  var isAM = false;
  var isPM = false;

  if (input.contains('a') || input.contains('A')) {
    isAM = true;
  } else if (input.contains('p') || input.contains('P')) {
    isPM = true;
  }

  if (input.contains(':')) {
    final split = input.split(':');
    var hour = int.tryParse(split.first) ?? 0;
    if (isPM && hour <= 12) hour += 12;
    final minute = int.tryParse(split[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }
  if (input.contains('.')) {
    final split = input.split('.');
    final hour = int.parse(split.first);
    // 60 minutes / 10
    final minute = 60 * int.parse(split[1]) ~/ 10;
    return TimeOfDay(hour: hour, minute: minute);
  }

  final num = int.parse(input);
  if (num <= 12 &&
      ((input.contains('m') && input.contains('M')) || isPM || isAM)) {
    if (isPM) {
      return TimeOfDay(hour: num * 12, minute: 0);
    } else {
      return TimeOfDay(hour: num, minute: 0);
    }
  } else {
    if (num.toString().length == 4) {
      var hour = (num / 100).ceil();
      final minute = num % 100;
      if (isPM && hour <= 12) {
        hour += 12;
      }
      return TimeOfDay(
        hour: hour,
        minute: minute,
      );
    }
    if (num.toString().length == 3) {
      var hour = (num / 100).ceil();
      final minute = num.remainder(100);

      if (isPM && hour <= 12) {
        hour += 12;
      }

      return TimeOfDay(hour: hour, minute: minute);
    }
  }

  return TimeOfDay(hour: 0, minute: num);
}
