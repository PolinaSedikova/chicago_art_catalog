import '../../../domain/artwork_model.dart';

sealed class ArtworkDetailState {
  const ArtworkDetailState();
}

final class ArtworkDetailLoading extends ArtworkDetailState {
  const ArtworkDetailLoading();
}

final class ArtworkDetailLoaded extends ArtworkDetailState {
  final ArtworkModel artwork;
  final List<ArtworkModel> relatedArtworks;

  const ArtworkDetailLoaded({
    required this.artwork,
    this.relatedArtworks = const [],
  });
}

final class ArtworkDetailNotFound extends ArtworkDetailState {
  const ArtworkDetailNotFound();
}
