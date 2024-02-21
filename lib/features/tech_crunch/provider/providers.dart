import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/external_interface/tech_crunch_api_external_interface.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/providers.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_entity.dart';
import 'package:daily_news_app/features/tech_crunch/domain/tech_crunch_usecase.dart';
import 'package:daily_news_app/features/tech_crunch/gateway/tech_crunch_gateway.dart';

final techCrunchUseCaseProvider =
    UseCaseProvider<TechCrunchEntity, TechCrunchUseCase>(
  TechCrunchUseCase.new,
  (bridge) {},
);

final techCrunchGatewayProvider = GatewayProvider(TechCrunchGateway.new,
    useCases: [techCrunchUseCaseProvider, bookMarkNewsUseCaseProvider]);

final techCrunchExternalInterfaceProvider =
    ExternalInterfaceProvider(TechCrunchApiExternalInterface.new, gateways: [
  techCrunchGatewayProvider,
]);
