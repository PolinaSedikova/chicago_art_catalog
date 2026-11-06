import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/artwork_model.dart';
import '../../../domain/i_artwork_repository.dart';
import 'artwork_list_state.dart';

class ArtworkListCubit extends Cubit<ArtworkListState> {
  final IArtworkRepository _repository;
  List<ArtworkModel> _allArtworks = [];

  ArtworkListCubit(this._repository) : super(const ArtworkListLoading());

  /// Первичная загрузка каталога
  Future<void> loadArtworks() async {
    emit(const ArtworkListLoading());
    _allArtworks = await _repository.getAllArtworks();
    emit(ArtworkListLoaded(artworks: _allArtworks));
  }

  /// Поиск по названию или автору
  void search(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      emit(ArtworkListLoaded(artworks: _allArtworks, query: ''));
      return;
    }

    final filtered = _allArtworks.where((artwork) {
      final titleMatch = artwork.title.toLowerCase().contains(trimmed.toLowerCase());
      final artistMatch = artwork.artistDisplay.toLowerCase().contains(trimmed.toLowerCase());
      return titleMatch || artistMatch;
    }).toList();

    if (filtered.isEmpty) {
      emit(ArtworkListEmpty(query: trimmed));
    } else {
      emit(ArtworkListLoaded(artworks: filtered, query: trimmed));
    }
  }

  /// Сброс поиска
  void clearSearch() {
    emit(ArtworkListLoaded(artworks: _allArtworks, query: ''));
  }
}