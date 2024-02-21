import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail.ui.dart';
import 'package:daily_news_app/features/tech_crunch/presentation/tech_crunch_presenter.dart';
import 'package:daily_news_app/features/tech_crunch/presentation/tech_crunch_view_model.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:daily_news_app/model/tech_data.dart';
import 'package:flutter/material.dart';

class TechCrunchUI extends UI<TechCrunchViewModel> {
  TechCrunchUI({super.key});

  @override
  Widget build(BuildContext context, TechCrunchViewModel viewModel) {
    return Scaffold(
      body: Column(children: [
        if (viewModel.isLoading)
          const Center(child: CircularProgressIndicator()),
        if (viewModel.isLoaded && viewModel.postList.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.postList.length,
              itemBuilder: (context, index) {
                print("inside techcrunch ui");
                var item = viewModel.postList[index];
                return InkWell(
                  key: UniqueKey(),
                  onTap: () {
                    _navigateToDetailScreen(context, item);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    color: Colors.white,
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            CachedNetworkImage(
                              imageUrl: item.jetpackFeaturedMediaUrl ?? "",
                              placeholder: (context, url) => SizedBox(
                                height: 150,
                                child: Center(
                                    child: Image.asset(
                                        "assets/images/image_placeholder.png")),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            InkWell(
                              onTap: () => viewModel.onBookMarkClicked(item),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: item.isBookMarked == true
                                        ? const Icon(Icons.bookmark)
                                        : const Icon(
                                            Icons.bookmark_add_outlined)),
                              ),
                            )
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            item.yoastHeadJson!.title ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.yoastHeadJson!.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(item.date ?? "",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomLeft,
                          //   child: Text(
                          //     "written by: ${item.yoastHeadJson!.author}",
                          //     style: const TextStyle(
                          //         fontStyle: FontStyle.italic,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      ]),
    );
  }

  @override
  Presenter<ViewModel, Output, UseCase<Entity>> create(WidgetBuilder builder) {
    return TechCrunchPresenter(builder: builder);
  }

  NewsData createNewsData(TechData techData) {
    return NewsData(
        author: techData.yoastHeadJson!.author,
        title: techData.yoastHeadJson!.title,
        description: techData.yoastHeadJson!.description,
        source: {},
        url: techData.yoastHeadJson!.ogUrl,
        urlToImage: techData.jetpackFeaturedMediaUrl,
        publishedAt: techData.yoastHeadJson!.articlePublishedTime,
        content: techData.yoastHeadJson!.description);
  }

  _navigateToDetailScreen(BuildContext context, TechData newsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewsDetailUI(newsData: createNewsData(newsData)),
    ));
  }
}
