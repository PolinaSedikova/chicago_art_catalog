import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chicago_art_catalog/common/theme/image_sources.dart';
import 'package:chicago_art_catalog/features/artwork/domain/artwork_model.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/utils/artwork_formatters.dart';

class RelatedArtworksSection extends StatelessWidget {
  final List<ArtworkModel> relatedArtworks;

  const RelatedArtworksSection({super.key, required this.relatedArtworks});

  @override
  Widget build(BuildContext context) {
    if (relatedArtworks.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          context.l10n.relatedArtworksTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            for (var i = 0; i < relatedArtworks.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              _buildTile(context, relatedArtworks[i], colorScheme),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTile(BuildContext context, ArtworkModel item, ColorScheme colorScheme) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      leading: CircleAvatar(
        backgroundColor: colorScheme.secondaryContainer,
        child: Text(
          ImageSources.getPlaceholderLetter(item.title),
          style: TextStyle(color: colorScheme.onSecondaryContainer),
        ),
      ),
      title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(item.dateDisplay),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () => context.push('/artwork/${item.id}'),
    );
  }
}