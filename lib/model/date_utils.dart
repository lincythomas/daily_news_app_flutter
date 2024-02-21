import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String format = "dd MMM yyy hh:mm aa";
convertDateTime(String inputDate) {
  var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(inputDate, true);
  var formatDate = DateFormat("dd MMM yyy hh:mm aa").format(dateTime);
  return formatDate.toString();
}

dateInTimesAgo(String inputDate) {
  String nowFormat = "yyyy-MM-dd HH:mm:ss.SSSSS";
  var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(inputDate, true);
  var inputFormattedDate =
      DateTime.parse(DateFormat(nowFormat).format(dateTime));
  var inputDateTime = DateTime(
    inputFormattedDate.year,
    inputFormattedDate.month,
    inputFormattedDate.day,
    inputFormattedDate.hour,
    inputFormattedDate.minute,
    inputFormattedDate.second,
  );
  var nowDateTime = DateTime.now();
  var difference = nowDateTime.difference(inputDateTime);

  final subtractedDate = DateTime.now().subtract(Duration(
      days: difference.inDays,
      hours: difference.inHours,
      minutes: difference.inMinutes,
      seconds: difference.inSeconds));
  return timeago.format(subtractedDate);
}

calculateDateTimeDifference({String inputDate = "2024-02-15T21:43:16"}) {
  // String nowFormat = "yyyy-MM-dd HH:mm:ss.SSSSS";
  // final now = DateTime.now();
  // print("***now $now");
  // var inputDateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(inputDate, true);
  // var formattedDate =
  //     DateTime.parse(DateFormat(nowFormat).format(inputDateTime));
  // print("***formatted date $formattedDate");
  // print("***same moment ${formattedDate.isAtSameMomentAs(now)}");
  // print("***after ${formattedDate.isAfter(now)}");
  // print("***before ${formattedDate.isAfter(now)}");
}
