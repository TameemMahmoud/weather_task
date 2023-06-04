import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';


class AppConstants{
  static const String countryCode =   '+2';
  static const double pagePadding = 16;
}


///dateTime format
var formatter = NumberFormat("#,##0", "en_US");
var format = DateFormat.yMMMEd('ar');

var timeFormat = DateFormat.jm('ar');
///dateTime format
