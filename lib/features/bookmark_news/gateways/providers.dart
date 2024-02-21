import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/external_interface/bookmark_news_external_inteface.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_entity.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_usecase.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/bookmark_news_gateway.dart';
import 'package:daily_news_app/features/tech_crunch/provider/providers.dart';

final bookMarkNewsUseCaseProvider =
    UseCaseProvider.autoDispose<BookMarkNewsEntity, BookMarkNewsUseCase>(
  BookMarkNewsUseCase.new,
  (bridge) {
    bridge.connect(techCrunchUseCaseProvider, (oldEntity, newEntity) {
      if (newEntity.bookMarkList != null) {
        bridge.useCase
            .setInput(RefreshListInput(bookMarkList: newEntity.bookMarkList!));
      }
    }, selector: (entity) => entity);
  },
);

final bookMarkGatewayProvider = GatewayProvider(BookMarkNewsGateway.new,
    useCases: [bookMarkNewsUseCaseProvider, techCrunchUseCaseProvider]);

final bookMarkExternalInterfaceProvider = ExternalInterfaceProvider(
    BookMarkNewsExternalInterface.new,
    gateways: [bookMarkGatewayProvider]);
