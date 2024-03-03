import 'package:intl/intl.dart';

String myDateFormate(DateTime dateTime){
String date = DateFormat( "EEE, dd MMM").format(dateTime);
  return date;
}