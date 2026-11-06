// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get catalogTitle => 'Институт искусств в Чикаго';

  @override
  String get searchHint => 'Поиск по названию или художнику...';

  @override
  String get searchClear => 'Очистить поиск';

  @override
  String emptySearchResult(String query) {
    return 'Ничего не найдено по запросу «$query»';
  }

  @override
  String get emptyCatalog => 'Каталог пуст';

  @override
  String get artistLabel => 'Художник';

  @override
  String get dateLabel => 'Дата создания';

  @override
  String get mediumLabel => 'Техника';

  @override
  String get relatedArtworksTitle => 'Другие работы этого автора';

  @override
  String get artworkNotFound => 'Экспонат не найден';

  @override
  String get switchThemeTooltip => 'Переключить тему';

  @override
  String get switchLocaleTooltip => 'Сменить язык';
}
