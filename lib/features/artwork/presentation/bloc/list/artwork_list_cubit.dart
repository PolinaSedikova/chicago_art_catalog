import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicago_art_catalog/features/artwork/domain/i_artwork_repository.dart';
import 'artwork_list_state.dart';

class ArtworkListCubit extends Cubit<ArtworkListState> {
  final IArtworkRepository _repository;
  String _latestQuery = '';

  ArtworkListCubit(this._repository) : super(const ArtworkListLoading());

  /// Единый метод загрузки и поиска
  Future<void> search([String query = '']) async {
    _latestQuery = query;
    emit(const ArtworkListLoading());

    final results = await _repository.searchArtworks(query);

    if (isClosed || query != _latestQuery) return;

    if (results.isEmpty && query.trim().isNotEmpty) {
      emit(ArtworkListEmpty(query: query.trim()));
    } else {
      emit(ArtworkListLoaded(artworks: results, query: query));
    }
  }

  void clearSearch() {
    search('');
  }
}