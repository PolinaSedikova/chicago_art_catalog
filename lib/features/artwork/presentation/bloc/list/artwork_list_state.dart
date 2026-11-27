import '../../../domain/artwork_model.dart';

sealed class ArtworkListState {
  const ArtworkListState();
}

final class ArtworkListLoading extends ArtworkListState {
  const ArtworkListLoading();
}

final class ArtworkListLoaded extends ArtworkListState {
  final List<ArtworkModel> artworks;
  final String query;

  const ArtworkListLoaded({
    required this.artworks,
    this.query = '',
  });
}

final class ArtworkListEmpty extends ArtworkListState {
  final String query;

  const ArtworkListEmpty({required this.query});
}
