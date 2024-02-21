import 'package:clean_framework/clean_framework.dart';

enum NewsDetailStatus { initial, loading, loaded, failed }

class NewsDetailEntity extends Entity {
  // final NewsData newsData;
  final NewsDetailStatus status;

  const NewsDetailEntity({this.status = NewsDetailStatus.initial});

  @override
  NewsDetailEntity copyWith({NewsDetailStatus? status}) {
    return NewsDetailEntity(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
