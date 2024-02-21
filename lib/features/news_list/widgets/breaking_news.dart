import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

class BrekingNewsScreen extends StatelessWidget {
  const BrekingNewsScreen(
      {super.key, required this.breakingNewsList, required this.onClick});

  final List<NewsData> breakingNewsList;
  final Function(NewsData data) onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Breaking News",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        CarouselSlider(
            items: breakingNewsList
                .map((data) => InkWell(
                      onTap: () => onClick(data),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black,
                          backgroundBlendMode: BlendMode.darken,
                          image: DecorationImage(
                              opacity: 0.8,
                              image: NetworkImage(data.urlToImage ?? ""),
                              fit: BoxFit.fill),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.title ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 170,
              // scrollPhysics: const ClampingScrollPhysics(),
            )),
        // Expanded(
        //   child: ListView.builder(
        //     physics: const ClampingScrollPhysics(),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: breakingNewsList.length,
        //     itemBuilder: (context, index) {
        //       var data = breakingNewsList[index];
        //       return Container(
        //         height: 170,
        //         width: MediaQuery.of(context).size.width,
        //         margin: const EdgeInsets.symmetric(horizontal: 5),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(16),
        //           color: Colors.black,
        //           backgroundBlendMode: BlendMode.darken,
        //           image: DecorationImage(
        //               opacity: 0.8,
        //               image: NetworkImage(data.urlToImage ?? ""),
        //               fit: BoxFit.fill),
        //         ),
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Text(
        //                 data.title ?? "",
        //                 style: const TextStyle(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 15,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
