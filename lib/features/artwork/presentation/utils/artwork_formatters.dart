import 'package:flutter/material.dart';
import 'package:chicago_art_catalog/common/l10n/app_localizations.dart';
import 'package:chicago_art_catalog/features/artwork/domain/artwork_model.dart';

extension BuildContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension ArtworkModelFormatting on ArtworkModel {
  String get initialLetter =>
      title.isNotEmpty ? title.characters.first.toUpperCase() : '?';

  String get subtitle => '$artistDisplay, $dateDisplay';
}