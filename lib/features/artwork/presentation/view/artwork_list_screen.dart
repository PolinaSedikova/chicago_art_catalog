import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/l10n/locale_cubit.dart';
import '../../../../common/theme/theme_cubit.dart';
import '../bloc/list/artwork_list_cubit.dart';
import '../bloc/list/artwork_list_state.dart';
import '../utils/artwork_formatters.dart';
import 'widgets/artwork_card.dart';

class ArtworkListScreen extends StatelessWidget {
  const ArtworkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.catalogTitle),
        actions: [
          // Переключение языка
          IconButton(
            tooltip: context.l10n.switchLocaleTooltip,
            icon: const Icon(Icons.language),
            onPressed: () => context.read<LocaleCubit>().toggleLocale(),
          ),
          // Переключение темы (светлая/тёмная)
          IconButton(
            tooltip: context.l10n.switchThemeTooltip,
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Поле поиска (значение передаётся в кубит)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BlocBuilder<ArtworkListCubit, ArtworkListState>(
              builder: (context, state) {
                final currentQuery = switch (state) {
                  ArtworkListLoaded(:final query) => query,
                  ArtworkListEmpty(:final query) => query,
                  _ => '',
                };

                return SearchBar(
                  hintText: context.l10n.searchHint,
                  elevation: const WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerHighest),
                  leading: const Icon(Icons.search),
                  trailing: [
                    if (currentQuery.isNotEmpty)
                      IconButton(
                        tooltip: context.l10n.searchClear,
                        icon: const Icon(Icons.clear),
                        onPressed: () => context.read<ArtworkListCubit>().clearSearch(),
                      ),
                  ],
                  onChanged: (value) => context.read<ArtworkListCubit>().search(value),
                );
              },
            ),
          ),
          // Основное состояние: загрузка, пустой поиск или список
          Expanded(
            child: BlocBuilder<ArtworkListCubit, ArtworkListState>(
              builder: (context, state) {
                return switch (state) {
                  ArtworkListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ArtworkListEmpty(:final query) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        context.l10n.emptySearchResult(query),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ArtworkListLoaded(:final artworks) => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: artworks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return ArtworkCard(artwork: artworks[index]);
                      },
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}