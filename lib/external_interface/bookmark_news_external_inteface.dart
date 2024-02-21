import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_entity.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/bookmark_news_gateway.dart';
import 'package:daily_news_app/features/bookmark_news/helper/databse_helper.dart';

class BookMarkNewsExternalInterface extends ExternalInterface<
    BookMarkNewsGatewayRequest, BookMarkSuccessResponse> {
  BookMarkNewsExternalInterface() : _dataBaseHelper = DataBaseHelper();
  // _postsController = StreamController<List<BookMarkData>>.broadcast();

  final DataBaseHelper _dataBaseHelper;
  /*  final StreamController<List<BookMarkData>> _postsController;
  StreamSink<List<BookMarkData>> get postsSink => _postsController.sink;
  Stream<List<BookMarkData>> get postListStream => _postsController.stream; */

  @override
  void handleRequest() {
    on<BookMarkNewsGatewayRequest>((request, send) async {
      switch (request.requestType) {
        case RequestType.add:
          {
            int result =
                await _dataBaseHelper.insertArticle(request.bookMarkData);
            if (result != 0) {
              final bookMarkList = _dataBaseHelper.fetchBookMarks();
              // postsSink.add(bookMarkList);

              send(
                BookMarkSuccessResponse(
                    message: "BookMarked", bookMarkList: bookMarkList),
              );
            }
          }
        case RequestType.delete:
          {
            await _dataBaseHelper.deleteArticle(request.bookMarkData.id);

            final bookMarkList = _dataBaseHelper.fetchBookMarks();
            // postsSink.add(bookMarkList);

            send(BookMarkSuccessResponse(
                message: "Removed from BookMarks", bookMarkList: bookMarkList));
          }
        case RequestType.fetch:
          {
            final bookMarkList = _dataBaseHelper.fetchBookMarks();
            // postsSink.add(bookMarkList);
            print("fetched from db ${bookMarkList}");
            send(BookMarkSuccessResponse(bookMarkList: bookMarkList));
          }
        default:
      }
    });
  }

  @override
  FailureResponse onError(Object error) {
    return UnknownFailureResponse(error);
  }
}
