import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicago_art_catalog/common/theme/image_sources.dart';
import 'package:chicago_art_catalog/features/artwork/domain/i_artwork_repository.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/bloc/detail/artwork_detail_cubit.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/bloc/detail/artwork_detail_state.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/utils/artwork_formatters.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/view/widgets/related_artworks_section.dart';

class ArtworkDetailScreen extends StatelessWidget {
  final int artworkId;

  const ArtworkDetailScreen({super.key, required this.artworkId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtworkDetailCubit(
        context.read<IArtworkRepository>(),
      )..loadDetail(artworkId),
      child: const _ArtworkDetailView(),
    );
  }
}

class _ArtworkDetailView extends StatelessWidget {
  const _ArtworkDetailView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ArtworkDetailCubit, ArtworkDetailState>(
          builder: (context, state) {
            return Text(
              state is ArtworkDetailLoaded ? state.artwork.title : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
      body: BlocBuilder<ArtworkDetailCubit, ArtworkDetailState>(
        builder: (context, state) {
          return switch (state) {
            ArtworkDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ArtworkDetailNotFound() => Center(
                child: Text(context.l10n.artworkNotFound),
              ),
            ArtworkDetailLoaded(:final artwork, :final relatedArtworks) =>
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заглушка картины
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        ImageSources.getPlaceholderLetter(artwork.title),
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Название экспоната
                    Text(
                      artwork.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Атрибуты картины 
                    _AttributeTile(
                      label: context.l10n.artistLabel,
                      value: artwork.artistDisplay,
                    ),
                    _AttributeTile(
                      label: context.l10n.dateLabel,
                      value: artwork.dateDisplay,
                    ),
                    _AttributeTile(
                      label: context.l10n.mediumLabel,
                      value: artwork.mediumDisplay,
                    ),
                    // Блок связанных работ того же автора
                    RelatedArtworksSection(relatedArtworks: relatedArtworks),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}

class _AttributeTile extends StatelessWidget {
  final String label;
  final String value;

  const _AttributeTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}