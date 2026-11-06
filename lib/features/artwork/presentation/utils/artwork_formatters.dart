import 'package:flutter/material.dart';
import '../../../../common/l10n/app_localizations.dart';
import '../../domain/artwork_model.dart';

extension BuildContextL10n on BuildContext {
  /// Быстрый доступ к переводам без громоздкого AppLocalizations.of(context)!
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension ArtworkModelFormatting on ArtworkModel {
  /// Первая буква названия для красивой плашки-аватара (как в вашей KMP-версии)
  String get initialLetter =>
      title.isNotEmpty ? title.characters.first.toUpperCase() : '?';

  /// Компактная подпись автора и года
  String get subtitle => '$artistDisplay, $dateDisplay';
}