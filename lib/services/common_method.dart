import 'package:intl/intl.dart';

class CommonMethod {
  String formatDate(DateTime date, String formate) {
    var formatter = DateFormat(formate);
    String formattedDateTime = formatter.format(date);
    return formattedDateTime;
  }
}
