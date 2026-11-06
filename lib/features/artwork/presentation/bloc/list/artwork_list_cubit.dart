import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicago_art_catalog/features/artwork/domain/artwork_model.dart';
import 'package:chicago_art_catalog/features/artwork/domain/i_artwork_repository.dart';
import 'artwork_list_state.dart';

class ArtworkListCubit extends Cubit<ArtworkListState> {
  final IArtworkRepository _repository;
  List<ArtworkModel> _allArtworks = [];

  ArtworkListCubit(this._repository) : super(const ArtworkListLoading());

  Future<void> loadArtworks() async {
    emit(const ArtworkListLoading());
    _allArtworks = await _repository.getAllArtworks();
    emit(ArtworkListLoaded(artworks: _allArtworks));
  }

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

  void clearSearch() {
    emit(ArtworkListLoaded(artworks: _allArtworks, query: ''));
  }
}