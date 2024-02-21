import 'dart:async';

import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_controller.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_entity.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/bookmark_news_gateway.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_ui_output.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_entity.dart';
import 'package:daily_news_app/features/tech_crunch/gateway/tech_crunch_gateway.dart';
import 'package:daily_news_app/model/bookmark_data.dart';
import 'package:daily_news_app/model/tech_data.dart';

class TechCrunchUseCase extends UseCase<TechCrunchEntity> {
  TechCrunchUseCase()
      : super(
            entity: const TechCrunchEntity(
              postList: [],
              isBookMarked: false,
            ),
            transformers: [
              OutputTransformer.from((entity) {
                return TechCrunchUIOutput(
                    isBookMarked: entity.isBookMarked,
                    status: entity.status,
                    postList: entity.postList);
              })
            ]);
  final BookMarkController controller = BookMarkController();

  Future<void> fetchPosts() async {
    entity = entity.copyWith(status: ScreenStatus.loading);
    var input = await getInput(TechCrunchGatewayOutput());
    switch (input) {
      case Success(:TechCrunchSuccessInput input):
        {
          fetchBookMarks(input.techDataList);
        }
      case _:
        {
          entity = entity.copyWith(status: ScreenStatus.failed);
        }
    }
  }

  Future<void> fetchBookMarks(List<TechData> techDataList) async {
    var input = await getInput(BookMarkNewsGatewayOutput(
        bookMarkData: BookMarkData.empty(), requestType: RequestType.fetch));

    switch (input) {
      case Success(:BookMarkNewsSuccessInput input):
        {
          List<int> indexList = [];
          var bookmarkedList = input.bookMarkList.asBroadcastStream();
          bookmarkedList.forEach((list) {
            for (var element in list) {
              indexList.add(element.id);
            }
          }).then((value) {
            if (indexList.isNotEmpty) {
              for (var indexElement in indexList) {
                for (var techData in techDataList) {
                  if (indexElement == techData.id) {
                    techData.isBookMarked = true;
                  }
                }
              }
            }
            entity = entity.copyWith(
                status: ScreenStatus.loaded, postList: techDataList);
          });
        }
      case _:
        {}
    }
  }

  Future<void> onBookMark(TechData techData) async {
    var input = await getInput(BookMarkNewsGatewayOutput(
        bookMarkData: BookMarkData(
            id: techData.id,
            title: techData.yoastHeadJson?.title ?? "",
            description: techData.yoastHeadJson?.description ?? "",
            imageUrl: techData.jetpackFeaturedMediaUrl ?? "",
            publishedAt: techData.date ?? "",
            content: techData.yoastHeadJson?.description ?? "",
            author: techData.yoastHeadJson?.author ?? ""),
        requestType: RequestType.add));

    switch (input) {
      case Success(:BookMarkNewsSuccessInput input):
        {
          var index =
              entity.postList.indexWhere((element) => element == techData);
          var tempPost = techData;
          tempPost.isBookMarked = true;
          // print("temPost ${tempPost} index ${index}");
          var tempList = entity.postList;
          tempList[index] = tempPost;
          // print("temp list $tempList")

          entity = entity.copyWith(
            bookMarkList: input.bookMarkList,
            isBookMarked: true,
            postList: tempList,
          );
          entity = entity.copyWith(isBookMarked: false);
        }
      case _:
        {
          entity = entity.copyWith(isBookMarked: false);
        }
    }
  }

  Future<void> deleteBookMark(TechData techData) async {
    var input = await getInput(BookMarkNewsGatewayOutput(
        bookMarkData: BookMarkData(
            id: techData.id,
            title: techData.yoastHeadJson?.title ?? "",
            description: techData.yoastHeadJson?.description ?? "",
            imageUrl: techData.jetpackFeaturedMediaUrl ?? "",
            publishedAt: techData.date ?? "",
            content: techData.yoastHeadJson?.description ?? "",
            author: techData.yoastHeadJson?.author ?? ""),
        requestType: RequestType.delete));
    switch (input) {
      case Success(:BookMarkNewsSuccessInput input):
        {
          var index =
              entity.postList.indexWhere((element) => element == techData);
          var tempPost = techData;
          tempPost.isBookMarked = false;
          // print("temPost ${tempPost} index ${index}");
          var tempList = entity.postList;
          tempList[index] = tempPost;

          entity = entity.copyWith(
            bookMarkList: input.bookMarkList,
            isBookMarked: true,
            postList: tempList,
          );
          entity = entity.copyWith(isBookMarked: false);
        }
      case _:
        {
          entity = entity.copyWith(isBookMarked: false);
        }
    }
  }
}
