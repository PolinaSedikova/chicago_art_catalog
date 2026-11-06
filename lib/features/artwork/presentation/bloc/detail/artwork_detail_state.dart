import '../../../domain/artwork_model.dart';

sealed class ArtworkDetailState {
  const ArtworkDetailState();
}

/// Состояние загрузки данных картины
final class ArtworkDetailLoading extends ArtworkDetailState {
  const ArtworkDetailLoading();
}

/// Состояние успешной загрузки: текущая картина и список связанных работ автора
final class ArtworkDetailLoaded extends ArtworkDetailState {
  final ArtworkModel artwork;
  final List<ArtworkModel> relatedArtworks;

  const ArtworkDetailLoaded({
    required this.artwork,
    this.relatedArtworks = const [],
  });
}

/// Состояние, если картины с таким id нет
final class ArtworkDetailNotFound extends ArtworkDetailState {
  const ArtworkDetailNotFound();
}