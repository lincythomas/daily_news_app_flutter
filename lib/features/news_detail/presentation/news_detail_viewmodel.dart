import 'package:clean_framework/clean_framework.dart';

class NewsDetailViewModel extends ViewModel {
  final bool isLoading;

  const NewsDetailViewModel({required this.isLoading});
  @override
  List<Object?> get props => [isLoading];
}
