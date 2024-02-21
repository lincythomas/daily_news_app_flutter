import 'dart:async';

import 'package:daily_news_app/model/bookmark_data.dart';

class BookMarkController {
  final StreamController<List<BookMarkData>> controller =
      StreamController.broadcast();

  StreamSink<List<BookMarkData>> get sink => controller.sink;
  Stream<List<BookMarkData>> get stream => controller.stream;

  dispose() {
    controller.close();
  }
}
