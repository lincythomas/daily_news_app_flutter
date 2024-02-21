import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

class HealthNews extends StatelessWidget {
  const HealthNews({super.key, required this.healthNewsList});

  final List<NewsData> healthNewsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Some Healthy Bites For You",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: healthNewsList.length,
            itemBuilder: (context, index) {
              var item = healthNewsList[index];
              return Container(
                width: 170,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.urlToImage ?? ""),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
