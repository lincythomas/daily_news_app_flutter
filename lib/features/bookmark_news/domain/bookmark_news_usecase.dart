import 'dart:async';

import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_entity.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_ui_output.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/bookmark_news_gateway.dart';
import 'package:daily_news_app/model/bookmark_data.dart';

class BookMarkNewsUseCase extends UseCase<BookMarkNewsEntity> {
  BookMarkNewsUseCase()
      : super(
            entity: const BookMarkNewsEntity(
              deletedId: -1,
              status: BookMarkScreenStatus.initial,
            ),
            transformers: [
              OutputTransformer.from((entity) => BookMarkNewsUIOutput(
                  bookMarkList: entity.bookMarkList, status: entity.status)),
              RefreshInputTransformer(),
            ]);

  Future<void> fetchBookMarks() async {
    entity = entity.copyWith(status: BookMarkScreenStatus.loading);
    var input = await getInput(BookMarkNewsGatewayOutput(
        bookMarkData: BookMarkData.empty(), requestType: RequestType.fetch));

    switch (input) {
      case Success(:BookMarkNewsSuccessInput input):
        {
          entity = entity.copyWith(
              bookMarkList: input.bookMarkList,
              status: BookMarkScreenStatus.loaded);
        }
      case _:
        {
          entity = entity.copyWith(status: BookMarkScreenStatus.failed);
        }
    }
  }

  Future<void> deleteBookMark(BookMarkData bookMarkData) async {
    var input = await getInput(BookMarkNewsGatewayOutput(
        bookMarkData: bookMarkData, requestType: RequestType.delete));
    switch (input) {
      case Success(:BookMarkNewsSuccessInput input):
        {
          entity = entity.copyWith(
              deletedId: bookMarkData.id,
              bookMarkList: input.bookMarkList,
              status: BookMarkScreenStatus.deleted);
        }
      case _:
        {
          entity = entity.copyWith(status: BookMarkScreenStatus.failed);
        }
    }
  }
}

class RefreshListInput extends SuccessInput {
  // final bool isRefresh;
  final Stream<List<BookMarkData>> bookMarkList;

  RefreshListInput({required this.bookMarkList});
}

class RefreshInputTransformer
    extends InputTransformer<BookMarkNewsEntity, RefreshListInput> {
  @override
  BookMarkNewsEntity transform(
      BookMarkNewsEntity entity, RefreshListInput input) {
    return entity.copyWith(bookMarkList: input.bookMarkList);
  }
}
