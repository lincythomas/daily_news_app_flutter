import 'package:daily_news_app/model/date_utils.dart';

class NewsData {
  final String? author;
  final String? title;
  final String? description;
  final Map<String, String>? source;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final bool? showLoader;
  int id = 0;

  NewsData(
      {required this.author,
      required this.title,
      required this.description,
      required this.source,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      this.showLoader = false,
      this.id = 0});

  factory NewsData.empty() {
    return NewsData(
        author: "",
        title: "",
        description: "",
        source: {},
        url: "",
        urlToImage: "",
        publishedAt: "",
        content: "",
        showLoader: false);
  }

  factory NewsData.addDummyNode(bool showLoader) {
    return NewsData(
        author: "",
        title: "",
        description: "",
        source: {},
        url: "",
        urlToImage: "",
        publishedAt: "",
        content: "",
        showLoader: showLoader);
  }

  factory NewsData.isNull() {
    return NewsData(
        author: null,
        title: null,
        description: null,
        source: {},
        url: null,
        urlToImage: null,
        publishedAt: null,
        content: null,
        showLoader: null);
  }

  factory NewsData.sample() {
    return NewsData(
        author: "Filipe Espósito",
        title:
            "Apple Vision Pro glass may not break easily, but it’s highly susceptible to scratches",
        description:
            "As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass on the Vision Pro has proven to be quite resistant to accide…",
        source: {},
        url: "",
        urlToImage:
            "https://i0.wp.com/9to5mac.com/wp-content/uploads/sites/6/2024/02/vision-pro-unboxing-0003.jpg?resize=1200%2C628&quality=82&strip=all&ssl=1",
        publishedAt: "2024-02-08T05:48:14Z",
        content:
            "As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass … [+1790 chars]");
  }

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
        author: json['author'],
        title: json['title'],
        description: json['description'],
        source: {},
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }

  factory NewsData.updateDate(NewsData data) {
    return NewsData(
        author: data.author,
        title: data.title,
        description: data.description,
        source: data.source,
        url: data.url,
        urlToImage: data.urlToImage,
        publishedAt: convertDateTime(data.publishedAt!),
        content: data.content);
  }

  NewsData copyWith(
          {String? author,
          String? title,
          String? description,
          Map<String, String>? source,
          String? url,
          String? urlToImage,
          String? publishedAt,
          String? content}) =>
      NewsData(
          author: author ?? this.author,
          title: title ?? this.title,
          description: description ?? this.description,
          source: source ?? this.source,
          url: url ?? this.url,
          urlToImage: urlToImage ?? this.urlToImage,
          publishedAt: publishedAt ?? this.publishedAt,
          content: content ?? this.content);

  @override
  String toString() {
    return " author: $author publishedAt: $publishedAt";
  }

  // @override
  // List<Object?> get props => [
  //       author,
  //       title,
  //       description,
  //       source,
  //       url,
  //       urlToImage,
  //       publishedAt,
  //       content
  //     ];
}
