import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail_presenter.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail_viewmodel.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewsDetailUI extends UI<NewsDetailViewModel> {
  NewsDetailUI({
    super.key,
    required this.newsData,
  });

  final NewsData newsData;
  var notFound =
      "https://previews.123rf.com/images/pavlostv/pavlostv1805/pavlostv180500098/100847458-oops-404-error-page-not-found-futuristic-robot-concept-%E2%80%93-stock-vector.jpg";
  // var noImageFound =
  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ17KAwfE2OsKRF3OATWG3wvVWzlzBedBOvOFctE0U8_a3KOzqqpyxoZqHTv7ZWTjwNefM&usqp=CAU";

  @override
  Widget build(BuildContext context, NewsDetailViewModel viewModel) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: Text(newsData.title ?? "News Detail Screen"),
      // ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(newsData.urlToImage ?? notFound),
                  onError: (exception, stackTrace) => Icon(Icons.error),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 35,
                  left: 10,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1.0,
                              spreadRadius: 0.0,
                              offset: Offset(1.0, 1.0),
                            )
                          ]),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // x
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      newsData.title ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Published on  ${newsData.publishedAt}',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      newsData.content ?? 'No content avaialble',
                      style: const TextStyle(fontSize: 16),
                    ),
                    // Text(newsData.description ?? ""),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Presenter<ViewModel, Output, UseCase<Entity>> create(WidgetBuilder builder) {
    return NewsDetailPresenter(
      builder: builder,
      newsData: newsData,
    );
  }
}
