import '../domain/artwork_model.dart';
import '../domain/i_artwork_repository.dart';
import 'artwork_mocks.dart';

class ArtworkRepository implements IArtworkRepository {
  @override
  Future<List<ArtworkModel>> getAllArtworks() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return mockArtworks;
  }

  @override
  Future<List<ArtworkModel>> searchArtworks(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return mockArtworks;

    return mockArtworks.where((artwork) {
      final titleMatch = artwork.title.toLowerCase().contains(trimmed);
      final artistMatch = artwork.artistDisplay.toLowerCase().contains(trimmed);
      return titleMatch || artistMatch;
    }).toList();
  }

  @override
  Future<ArtworkModel?> getArtworkById(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      return mockArtworks.firstWhere((art) => art.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ArtworkModel>> getRelatedArtworks({
    required int currentId,
    required String artistDisplay,
  }) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return mockArtworks
        .where((art) => art.id != currentId && art.artistDisplay == artistDisplay)
        .toList();
  }
}