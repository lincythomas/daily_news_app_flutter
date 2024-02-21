import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/presentation/bookmark_news_presenter.dart';
import 'package:daily_news_app/features/bookmark_news/presentation/bookmark_news_viewmodel.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail.ui.dart';
import 'package:daily_news_app/features/news_list/widgets/category_news.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

class BookMarkNewsUI extends UI<BookMarkNewsViewModel> {
  BookMarkNewsUI({super.key});

  @override
  Widget build(BuildContext context, BookMarkNewsViewModel viewModel) {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //     onPressed: () => viewModel.fetchBookMark(),
          //     child: const Text('Fetch bookmarks')),
          (viewModel.bookMarkList == null)
              ? const Text("No bookmarks to show now")
              : StreamBuilder(
                  stream: viewModel.bookMarkList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData) {
                      return showNoBookMarks();
                    }

                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    final list = snapshot.data!;
                    return Expanded(
                      child: list.isEmpty
                          ? showNoBookMarks()
                          : ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                var data = list[index];
                                return InkWell(
                                  onTap: () {
                                    _navigateToDetailScreen(
                                        context, data.convertToNewsData(data));
                                  },
                                  child: CategoryNews(
                                    categoryNews: data.convertToNewsData(
                                      data,
                                    ),
                                    callFrom: "",
                                    onDelete: () => viewModel.onDelete(data),
                                  ),
                                );
                              },
                            ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Expanded showNoBookMarks() => const Expanded(
          child: Center(
              child: Text(
        "No bookmarks yet!",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      )));

  @override
  Presenter<ViewModel, Output, UseCase<Entity>> create(WidgetBuilder builder) {
    return BookMarkNewsPresenter(builder: builder);
  }

  _navigateToDetailScreen(BuildContext context, NewsData newsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewsDetailUI(newsData: newsData),
    ));
  }
}
