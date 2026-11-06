import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_artwork_repository.dart';
import 'artwork_detail_state.dart';

class ArtworkDetailCubit extends Cubit<ArtworkDetailState> {
  final IArtworkRepository _repository;

  ArtworkDetailCubit(this._repository) : super(const ArtworkDetailLoading());

  /// Загрузка картины по ID и поиск связанных картин того же автора
  Future<void> loadDetail(int id) async {
    emit(const ArtworkDetailLoading());
    final artwork = await _repository.getArtworkById(id);

    if (artwork == null) {
      emit(const ArtworkDetailNotFound());
      return;
    }

    final related = await _repository.getRelatedArtworks(
      currentId: artwork.id,
      artistDisplay: artwork.artistDisplay,
    );

    emit(ArtworkDetailLoaded(
      artwork: artwork,
      relatedArtworks: related,
    ));
  }
}