import 'package:flutter/material.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/values/constants.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  bool get isValidEmail {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(this)) {
      return false;
    } else {
      return true;
    }
  }

  Color get toHexColor {
    final buffer = StringBuffer();
    if (length < 6 || isEmpty) {
      return ColorsX.bgGrey;
    }
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  DateTime get toDateTime {
    return DateFormat(Constant.dateTimeFormat).parse(this, true).toLocal();
  }

  DateTime get toDate {
    return DateFormat(Constant.dateFormat).parse(this, true).toLocal();
  }

  DateTime toDateFormat(String format, {bool utc = true}) {
    if (utc) {
      return DateFormat(format).parse(this, utc).toLocal();
    } else {
      return DateFormat(format).parse(this, utc);
    }
  }

  DateTime get toTime {
    return DateFormat(Constant.timeFormat).parse(this, true).toLocal();
  }

  String toDateTimeString(String format) {
    return DateFormat(format).format(toDateTime);
  }

  int get getDayDifferenceToday {
    return toDateTime.difference(DateTime.now()).inDays;
  }

  String get commaSeparated {
    if (length <= 3) {
      return this;
    }
    var formatter = NumberFormat('#,##,000');
    return formatter.format(int.parse(this));
  }
}

extension DateHelpers on DateTime {
  String toDateTimeString(String format) {
    return DateFormat(format).format(this);
  }
}
