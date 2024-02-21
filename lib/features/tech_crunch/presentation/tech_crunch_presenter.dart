import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/tech_data.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_entity.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_ui_output.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_usecase.dart';
import 'package:daily_news_app/features/tech_crunch/presentation/tech_crunch_view_model.dart';
import 'package:daily_news_app/features/tech_crunch/provider/providers.dart';

class TechCrunchPresenter extends Presenter<TechCrunchViewModel,
    TechCrunchUIOutput, TechCrunchUseCase> {
  TechCrunchPresenter({super.key, required super.builder})
      : super(provider: techCrunchUseCaseProvider);

  @override
  void onLayoutReady(BuildContext context, TechCrunchUseCase useCase) {
    useCase.fetchPosts();
  }

  @override
  TechCrunchViewModel createViewModel(
      TechCrunchUseCase useCase, TechCrunchUIOutput output) {
    return TechCrunchViewModel(
        isFetchFailed: output.status == ScreenStatus.failed,
        isLoading: output.status == ScreenStatus.loading,
        isLoaded: output.status == ScreenStatus.loaded,
        postList: output.postList,
        onBookMarkClicked: (TechData value) {
          if (value.isBookMarked == true) {
            useCase.deleteBookMark(value);
          } else {
            useCase.onBookMark(value);
          }
        },
        isBookMarked: output.isBookMarked);
  }
}
