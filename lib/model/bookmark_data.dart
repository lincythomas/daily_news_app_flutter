import 'package:daily_news_app/model/news_data.dart';

class BookMarkData {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String publishedAt;
  final String content;
  final String author;

  BookMarkData(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.publishedAt,
      required this.content,
      required this.author});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
      'content': content,
      'author': author
    };
  }

  factory BookMarkData.empty() {
    return BookMarkData(
        id: 0,
        title: "",
        description: "",
        imageUrl: "",
        publishedAt: "",
        content: "",
        author: "");
  }

  NewsData convertToNewsData(BookMarkData data) {
    return NewsData(
        author: data.author,
        title: data.title,
        description: data.description,
        source: {},
        url: "",
        urlToImage: data.imageUrl,
        publishedAt: data.publishedAt,
        content: data.content,
        id: data.id);
  }
}
