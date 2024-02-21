import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_entity.dart';
import 'package:daily_news_app/model/tech_data.dart';

class TechCrunchUIOutput extends Output {
  final bool isBookMarked;
  final ScreenStatus status;
  final List<TechData> postList;
  const TechCrunchUIOutput(
      {required this.status,
      required this.postList,
      required this.isBookMarked});
  @override
  List<Object?> get props => [status, postList, isBookMarked];
}
