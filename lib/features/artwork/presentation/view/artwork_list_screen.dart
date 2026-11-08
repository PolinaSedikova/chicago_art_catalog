import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chicago_art_catalog/common/l10n/locale_cubit.dart';
import 'package:chicago_art_catalog/common/theme/theme_cubit.dart';
import '../bloc/list/artwork_list_cubit.dart';
import '../bloc/list/artwork_list_state.dart';
import '../utils/artwork_formatters.dart';
import 'widgets/artwork_card.dart';

class ArtworkListScreen extends StatefulWidget {
  const ArtworkListScreen({super.key});

  @override
  State<ArtworkListScreen> createState() => _ArtworkListScreenState();
}

class _ArtworkListScreenState extends State<ArtworkListScreen> {
  late final SearchController _searchController;

  @override
  void initStateExisting() {}

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.catalogTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.switchLocaleTooltip,
            icon: const Icon(Icons.language),
            onPressed: () => context.read<LocaleCubit>().toggleLocale(),
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BlocBuilder<ArtworkListCubit, ArtworkListState>(
              builder: (context, state) {
                final currentQuery = switch (state) {
                  ArtworkListLoaded(:final query) => query,
                  ArtworkListEmpty(:final query) => query,
                  _ => '',
                };

                // Синхронизируем текст в контроллере со стейтом при возврате на экран
                if (_searchController.text != currentQuery) {
                  _searchController.text = currentQuery;
                }

                return SearchBar(
                  controller: _searchController,
                  hintText: context.l10n.searchHint,
                  elevation: const WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerHighest),
                  leading: const Icon(Icons.search),
                  trailing: [
                    if (currentQuery.isNotEmpty)
                      IconButton(
                        tooltip: context.l10n.searchClear,
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<ArtworkListCubit>().clearSearch();
                        },
                      ),
                  ],
                  onChanged: (value) => context.read<ArtworkListCubit>().search(value),
                );
              },
            ),
          ),
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