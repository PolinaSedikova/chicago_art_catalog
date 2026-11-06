import 'artwork_model.dart';

abstract interface class IArtworkRepository {
  /// Получить полный список экспонатов
  Future<List<ArtworkModel>> getAllArtworks();

  /// Получить экспонат по ID для экрана детали
  Future<ArtworkModel?> getArtworkById(int id);

  /// Получить связанные работы того же автора
  Future<List<ArtworkModel>> getRelatedArtworks({
    required int currentId,
    required String artistDisplay,
  });
}