import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/theme/image_sources.dart';
import '../../domain/i_artwork_repository.dart';
import '../bloc/detail/artwork_detail_cubit.dart';
import '../bloc/detail/artwork_detail_state.dart';
import '../utils/artwork_formatters.dart';
import 'widgets/related_artworks_section.dart';

class ArtworkDetailScreen extends StatelessWidget {
  final int artworkId;

  const ArtworkDetailScreen({super.key, required this.artworkId});

  @override
  Widget build(BuildContext context) {
    // Экран сам создаёт свой Cubit (требование задания)
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
            ArtworkDetailLoading() => const Center(child: CircularProgressIndicator()),
            ArtworkDetailNotFound() => Center(
                child: Text(context.l10n.artworkNotFound),
              ),
            ArtworkDetailLoaded(:final artwork, :final relatedArtworks) =>
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Постер картины (с безопасной заглушкой при ошибке сети)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: 260,
                        color: colorScheme.surfaceContainerHighest,
                        child: Image.network(
                          ImageSources.getArtworkImageUrl(artwork.imageId),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.palette_outlined, size: 54, color: colorScheme.outline),
                                const SizedBox(height: 8),
                                Text(
                                  artwork.title,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Заголовок
                    Text(
                      artwork.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Карточки с атрибутами (Автор, Дата, Техника)
                    _AttributeTile(
                      label: context.l10n.artistLabel,
                      value: artwork.artistDisplay,
                      icon: Icons.person_outline,
                    ),
                    _AttributeTile(
                      label: context.l10n.dateLabel,
                      value: artwork.dateDisplay,
                      icon: Icons.calendar_today_outlined,
                    ),
                    _AttributeTile(
                      label: context.l10n.mediumLabel,
                      value: artwork.mediumDisplay,
                      icon: Icons.brush_outlined,
                    ),
                    // Секция связанных картин того же автора
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
  final IconData icon;

  const _AttributeTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}