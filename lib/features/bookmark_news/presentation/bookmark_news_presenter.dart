import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_ui_output.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_usecase.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/providers.dart';
import 'package:daily_news_app/features/bookmark_news/presentation/bookmark_news_viewmodel.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class BookMarkNewsPresenter extends Presenter<BookMarkNewsViewModel,
    BookMarkNewsUIOutput, BookMarkNewsUseCase> {
  BookMarkNewsPresenter({super.key, required super.builder})
      : super(provider: bookMarkNewsUseCaseProvider);
  @override
  void onLayoutReady(BuildContext context, BookMarkNewsUseCase useCase) {
    Future.delayed(
      const Duration(milliseconds: 30),
      () {
        useCase.fetchBookMarks();
      },
    );
  }

  @override
  BookMarkNewsViewModel createViewModel(
      BookMarkNewsUseCase useCase, BookMarkNewsUIOutput output) {
    return BookMarkNewsViewModel(
      bookMarkList: output.bookMarkList,
      fetchBookMark: () => useCase.fetchBookMarks(),
      onDelete: (value) => useCase.deleteBookMark(value),
    );
  }
}
