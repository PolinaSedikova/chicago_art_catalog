import '../../../domain/artwork_model.dart';

sealed class ArtworkListState {
  const ArtworkListState();
}

/// Состояние первоначальной загрузки списка
final class ArtworkListLoading extends ArtworkListState {
  const ArtworkListLoading();
}

/// Состояние успешной загрузки (полный список или результат поиска)
final class ArtworkListLoaded extends ArtworkListState {
  final List<ArtworkModel> artworks;
  final String query;

  const ArtworkListLoaded({
    required this.artworks,
    this.query = '',
  });
}

/// Состояние, когда поиск ничего не нашел (требование пункта 7)
final class ArtworkListEmpty extends ArtworkListState {
  final String query;

  const ArtworkListEmpty({required this.query});
}