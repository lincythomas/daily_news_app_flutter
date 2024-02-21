import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail.ui.dart';
import 'package:daily_news_app/features/news_list/presentation/new_list_presenter.dart';
import 'package:daily_news_app/features/news_list/presentation/news_list_viewmodel.dart';
import 'package:daily_news_app/features/news_list/widgets/breaking_news.dart';
import 'package:daily_news_app/features/news_list/widgets/category_news.dart';
import 'package:daily_news_app/features/news_list/widgets/category_tabs.dart';
import 'package:daily_news_app/features/news_list/widgets/sliverappbardelegate.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

class NewsListUI extends UI<NewsListViewModel> {
  NewsListUI({super.key});

  SliverPersistentHeader pinTabHeaders(Widget child) {
    return SliverPersistentHeader(
        pinned: true,
        delegate:
            SliverAppBarDelegate(minHeight: 70, maxHeight: 90, child: child));
  }

  @override
  Widget build(BuildContext context, NewsListViewModel viewModel) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: homeViewUsingCustomScrollView(viewModel, context),
    );
  }

  NestedScrollView homeUIUsingNestedScroll(NewsListViewModel viewModel) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: BrekingNewsScreen(
              breakingNewsList: viewModel.bbcNewsList,
              onClick: (data) => _navigateToDetailScreen(context, data),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: HealthNews(healthNewsList: viewModel.healthNewsList),
          // ),
          pinTabHeaders(CategoryTab(
            onClick: (index) => viewModel.onTabClicked(index),
          ))
        ];
      },
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 15,
            // ),
            // if (viewModel.healthNewsList.isNotEmpty)
            //   HealthNews(healthNewsList: viewModel.healthNewsList),

            if (viewModel.hasLoadingFailed)
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Center(
                    child: Text(
                  'Something went wrong',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
              ),
            if (viewModel.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator())),
            if (viewModel.newsList.isNotEmpty)
              Visibility(
                visible: !viewModel.isLoading && !viewModel.hasLoadingFailed,
                child: Expanded(
                  // child: RefreshIndicator(
                  //   onRefresh: () {
                  //     return viewModel.onRefresh();
                  //   },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: viewModel.newsList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      var news = viewModel.newsList[index];
                      return InkWell(
                        onTap: () => _navigateToDetailScreen(context, news),
                        child: CategoryNews(
                          categoryNews: news,
                          onDelete: () => (),
                        ),
                      );
                    }
                    // )
                    ,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  CustomScrollView homeViewUsingCustomScrollView(
      NewsListViewModel viewModel, BuildContext context) {
    return CustomScrollView(
      controller: viewModel.scrollController,
      slivers: [
        // SliverAppBar(
        //   collapsedHeight: 90,

        //   floating: true,
        //   snap: true,
        //   expandedHeight: 70,
        //   flexibleSpace: Container(
        //       margin: const EdgeInsets.only(
        //         top: 50,
        //       ),
        //       child: const WelcomeUser()),
        //   pinned: true,
        // ),
        if (viewModel.bbcNewsList.isNotEmpty)
          SliverToBoxAdapter(
            child: Column(
              children: [
                BrekingNewsScreen(
                  breakingNewsList: viewModel.bbcNewsList,
                  onClick: (data) => _navigateToDetailScreen(context, data),
                )
              ],
            ),
          ),
        if (!viewModel.isLoading)
          pinTabHeaders(CategoryTab(
            onClick: (index) => viewModel.onTabClicked(index),
          )),
        if (viewModel.newsList.isNotEmpty &&
            !viewModel.isTabDataLoading &&
            !viewModel.hasLoadingFailed)
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: viewModel.isLoadingMore
                    ? viewModel.newsList.length + 1
                    : viewModel.newsList.length, (context, index) {
              var news = viewModel.newsList[index];
              if (index < viewModel.newsList.length) {
                return InkWell(
                  onTap: () => _navigateToDetailScreen(context, news),
                  child: CategoryNews(
                    categoryNews: news,
                    onDelete: () => (),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),

        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              if (viewModel.hasLoadingFailed)
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: const Center(
                      child: Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
              if (viewModel.isLoading || viewModel.isTabDataLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
            ],
          ),
        )
      ],
    );
  }

  @override
  Presenter<ViewModel, Output, UseCase<Entity>> create(WidgetBuilder builder) {
    return NewsListPresenter(builder: builder);
  }

  _navigateToDetailScreen(BuildContext context, NewsData newsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewsDetailUI(newsData: newsData),
    ));
  }
}
