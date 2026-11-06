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
    // 1. Регистрация репозитория в корне по интерфейсу
    return RepositoryProvider<IArtworkRepository>(
      create: (_) => ArtworkRepository(),
      child: MultiBlocProvider(
        // 2. Глобальные провайдеры (тема, язык, каталог)
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
            )..loadArtworks(),
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
      title: 'Art Institute of Chicago',
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