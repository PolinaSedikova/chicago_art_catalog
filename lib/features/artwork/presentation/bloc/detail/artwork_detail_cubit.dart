import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicago_art_catalog/features/artwork/domain/i_artwork_repository.dart';
import 'artwork_detail_state.dart';

class ArtworkDetailCubit extends Cubit<ArtworkDetailState> {
  final IArtworkRepository _repository;

  ArtworkDetailCubit(this._repository) : super(const ArtworkDetailLoading());

  Future<void> loadDetail(int id) async {
    emit(const ArtworkDetailLoading());
    final artwork = await _repository.getArtworkById(id);

    if (isClosed) return;

    if (artwork == null) {
      emit(const ArtworkDetailNotFound());
      return;
    }

    final related = await _repository.getRelatedArtworks(
      currentId: artwork.id,
      artistDisplay: artwork.artistDisplay,
    );

    if (isClosed) return;

    emit(ArtworkDetailLoaded(
      artwork: artwork,
      relatedArtworks: related,
    ));
  }
}