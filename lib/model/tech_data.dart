import 'package:daily_news_app/model/date_utils.dart';

class TechData {
  final int id;
  final String? date;
  final String? slug;
  final String? type;
  final String? link;
  final Title? title;
  final Excerpt? excerpt;
  final int? author;
  final int? featuredMedia;
  final YoastHeadJson? yoastHeadJson;
  final bool? jetpackSharingEnabled;
  final String? jetpackFeaturedMediaUrl;
  final String? subtitle;
  bool? isBookMarked;

  TechData(
      {required this.id,
      this.date,
      this.slug,
      this.type,
      this.link,
      this.title,
      this.excerpt,
      this.author,
      this.featuredMedia,
      this.yoastHeadJson,
      this.jetpackSharingEnabled,
      this.jetpackFeaturedMediaUrl,
      this.subtitle,
      this.isBookMarked});
  @override
  String toString() {
    return "id $id date $date author $author isBookMarked $isBookMarked";
  }

  factory TechData.fromJson(Map<String, dynamic> json) {
    return TechData(
      id: json['id'],
      date: dateInTimesAgo(json['date']),
      slug: json['slug'],
      type: json['type'],
      link: json['link'],
      title: json['title'] != null ? Title.fromJson(json['title']) : null,
      excerpt:
          json['excerpt'] != null ? Excerpt.fromJson(json['excerpt']) : null,
      author: json['author'],
      featuredMedia: json['featured_media'],
      yoastHeadJson: json['yoast_head_json'] != null
          ? YoastHeadJson.fromJson(json['yoast_head_json'])
          : null,
      jetpackSharingEnabled: json['jetpack_sharing_enabled'],
      jetpackFeaturedMediaUrl: json['jetpack_featured_media_url'],
      subtitle: json['subtitle'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['date'] = this.date;
  //   data['slug'] = this.slug;
  //   data['type'] = this.type;
  //   data['link'] = this.link;
  //   if (this.title != null) {
  //     data['title'] = this.title.toJson();
  //   }
  //   if (this.excerpt != null) {
  //     data['excerpt'] = this.excerpt.toJson();
  //   }
  //   data['author'] = this.author;
  //   data['featured_media'] = this.featuredMedia;
  //   if (this.yoastHeadJson != null) {
  //     data['yoast_head_json'] = this.yoastHeadJson.toJson();
  //   }
  //   data['jetpack_sharing_enabled'] = this.jetpackSharingEnabled;
  //   data['jetpack_featured_media_url'] = this.jetpackFeaturedMediaUrl;
  //   data['subtitle'] = this.subtitle;
  //   return data;
  // }
}

class Title {
  final String? rendered;

  Title({this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Excerpt {
  final String? rendered;
  final bool? protected;

  Excerpt({this.rendered, this.protected});

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(rendered: json['rendered'], protected: json['protected']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class YoastHeadJson {
  final String? title;
  final String? description;
  final String? ogLocale;
  final String? ogType;
  final String? ogTitle;
  final String? ogDescription;
  final String? ogUrl;
  final String? ogSiteName;
  final String? articlePublisher;
  final String? articlePublishedTime;
  final String? articleModifiedTime;
  final List<OgImage>? ogImage;
  final String? author;

  YoastHeadJson(
      {this.title,
      this.description,
      this.ogLocale,
      this.ogType,
      this.ogTitle,
      this.ogDescription,
      this.ogUrl,
      this.ogSiteName,
      this.articlePublisher,
      this.articlePublishedTime,
      this.articleModifiedTime,
      this.ogImage,
      this.author});

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) {
    return YoastHeadJson(
        title: json['title'],
        description: json['description'],
        ogLocale: json['og_locale'],
        ogType: json['og_type'],
        ogTitle: json['og_title'],
        ogDescription: json['og_description'],
        ogUrl: json['og_url'],
        ogSiteName: json['og_site_name'],
        articlePublisher: json['article_publisher'],
        articlePublishedTime: json['article_published_time'],
        articleModifiedTime: json['article_modified_time'],
        // if (json['og_image'] != null) {
        //   ogImage = new List<OgImage>();
        //   json['og_image'].forEach((v) {
        //     ogImage.add(new OgImage.fromJson(v));
        //   });
        // }
        author: json['author']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['og_locale'] = this.ogLocale;
    data['og_type'] = this.ogType;
    data['og_title'] = this.ogTitle;
    data['og_description'] = this.ogDescription;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
    data['article_publisher'] = this.articlePublisher;
    data['article_published_time'] = this.articlePublishedTime;
    data['article_modified_time'] = this.articleModifiedTime;
    // if (this.ogImage != null) {
    //   data['og_image'] = this.ogImage.map((v) => v.toJson()).toList();
    // }
    data['author'] = this.author;
    return data;
  }
}

class OgImage {
  final int? width;
  final int? height;
  final String? url;
  final String? type;

  OgImage({this.width, this.height, this.url, this.type});

  factory OgImage.fromJson(Map<String, dynamic> json) {
    return OgImage(
        width: json['width'],
        height: json['height'],
        url: json['url'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}
