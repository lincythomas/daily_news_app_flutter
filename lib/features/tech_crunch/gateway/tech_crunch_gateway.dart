import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:daily_news_app/model/tech_data.dart';

class TechCrunchGateway extends Gateway<TechCrunchGatewayOutput,
    TechCrunchRequest, SuccessResponse, TechCrunchSuccessInput> {
  @override
  TechCrunchRequest buildRequest(TechCrunchGatewayOutput output) {
    return TechCrunchRequest();
  }

  @override
  FailureInput onFailure(covariant FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  TechCrunchSuccessInput onSuccess(JsonArrayHttpSuccessResponse response) {
    List<TechData> techList =
        (response.data).map<TechData>((e) => TechData.fromJson(e)).toList();
    return TechCrunchSuccessInput(techDataList: techList);
  }
}

class TechCrunchGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class TechCrunchRequest extends GetHttpRequest {
  @override
  String get path => 'posts?context=embed&per_page=10&page=1';
}

class TechCrunchSuccessInput extends SuccessInput {
  final List<TechData> techDataList;

  TechCrunchSuccessInput({required this.techDataList});
}
