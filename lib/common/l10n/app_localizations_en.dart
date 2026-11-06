// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get catalogTitle => 'Art Institute of Chicago';

  @override
  String get searchHint => 'Search artworks or artists...';

  @override
  String get searchClear => 'Clear search';

  @override
  String emptySearchResult(String query) {
    return 'Nothing found for \"$query\"';
  }

  @override
  String get emptyCatalog => 'Catalog is empty';

  @override
  String get artistLabel => 'Artist';

  @override
  String get dateLabel => 'Date';

  @override
  String get mediumLabel => 'Medium';

  @override
  String get relatedArtworksTitle => 'Other works by this artist';

  @override
  String get artworkNotFound => 'Artwork not found';

  @override
  String get switchThemeTooltip => 'Switch theme';

  @override
  String get switchLocaleTooltip => 'Switch language';
}
