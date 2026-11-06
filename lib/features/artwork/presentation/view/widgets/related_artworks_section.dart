import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: relatedArtworks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = relatedArtworks[index];
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
              ),
              leading: CircleAvatar(
                backgroundColor: colorScheme.secondaryContainer,
                child: Text(
                  item.initialLetter,
                  style: TextStyle(color: colorScheme.onSecondaryContainer),
                ),
              ),
              title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(item.dateDisplay),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => context.push('/artwork/${item.id}'),
            );
          },
        ),
      ],
    );
  }
}