import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String myDateFormate(DateTime dateTime){
String date = DateFormat( "EEE, dd MMM").format(dateTime);
  return date;
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
  );
  return pickedDate;
}