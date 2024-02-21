import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryNews extends StatelessWidget {
  const CategoryNews(
      {super.key,
      required this.categoryNews,
      this.callFrom = "",
      required this.onDelete});

  final NewsData categoryNews;
  final String callFrom;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  categoryNews.urlToImage ?? "",
                  fit: BoxFit.fitHeight,
                  height: 130,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        categoryNews.title ?? "null-content",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        categoryNews.publishedAt ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // const CircleAvatar(
                        //   backgroundColor: Colors.transparent,
                        //   radius: 15,
                        //   child: Icon(Icons.girl_rounded),
                        // ),
                        // const SizedBox(
                        //   width: 12,
                        // ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ' by ${categoryNews.author ?? "Anonymus"}',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        if (callFrom == "bookMark")
                          InkWell(
                            onTap: () => onDelete(),
                            child: const Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(Icons.delete)),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
