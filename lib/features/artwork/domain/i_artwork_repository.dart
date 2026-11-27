import 'artwork_model.dart';

abstract interface class IArtworkRepository {
  Future<List<ArtworkModel>> getAllArtworks();
  Future<List<ArtworkModel>> searchArtworks(String query);
  Future<ArtworkModel?> getArtworkById(int id);
  Future<List<ArtworkModel>> getRelatedArtworks({
    required int currentId,
    required String artistDisplay,
  });
}
