import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/l10n/app_localizations.dart';
import 'common/l10n/locale_cubit.dart';
import 'common/navigation/app_router.dart';
import 'common/theme/app_theme.dart';
import 'common/theme/theme_cubit.dart';
import 'features/artwork/data/artwork_repository.dart';
import 'features/artwork/domain/i_artwork_repository.dart';
import 'features/artwork/presentation/bloc/list/artwork_list_cubit.dart';

class ChicagoArtApp extends StatelessWidget {
  const ChicagoArtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IArtworkRepository>(
      create: (_) => ArtworkRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider<LocaleCubit>(
            create: (_) => LocaleCubit(),
          ),
          BlocProvider<ArtworkListCubit>(
            create: (context) => ArtworkListCubit(
              context.read<IArtworkRepository>(),
            )..search(''),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.catalogTitle,
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}