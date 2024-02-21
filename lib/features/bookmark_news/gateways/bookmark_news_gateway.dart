import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_entity.dart';
import 'package:daily_news_app/model/bookmark_data.dart';

class BookMarkNewsGateway extends Gateway<
    BookMarkNewsGatewayOutput,
    BookMarkNewsGatewayRequest,
    BookMarkSuccessResponse,
    BookMarkNewsSuccessInput> {
  @override
  BookMarkNewsGatewayRequest buildRequest(BookMarkNewsGatewayOutput output) {
    return BookMarkNewsGatewayRequest(
        bookMarkData: output.bookMarkData, requestType: output.requestType);
  }

  @override
  FailureInput onFailure(covariant FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  BookMarkNewsSuccessInput onSuccess(
      covariant BookMarkSuccessResponse response) {
    return BookMarkNewsSuccessInput(
        message: response.message, bookMarkList: response.bookMarkList);
  }
}

class BookMarkNewsGatewayOutput extends Output {
  final BookMarkData bookMarkData;
  final RequestType requestType;

  const BookMarkNewsGatewayOutput(
      {required this.bookMarkData, required this.requestType});

  @override
  List<Object?> get props => [bookMarkData, requestType];
}

class BookMarkNewsGatewayRequest extends Request {
  final BookMarkData bookMarkData;
  final RequestType requestType;

  const BookMarkNewsGatewayRequest(
      {required this.bookMarkData, required this.requestType});
}

class BookMarkNewsSuccessInput extends SuccessInput {
  final String message;
  final Stream<List<BookMarkData>> bookMarkList;

  BookMarkNewsSuccessInput({this.message = "", required this.bookMarkList});
}

class BookMarkSuccessResponse extends SuccessResponse {
  final String message;
  final Stream<List<BookMarkData>> bookMarkList;

  const BookMarkSuccessResponse(
      {this.message = "", required this.bookMarkList});
}
