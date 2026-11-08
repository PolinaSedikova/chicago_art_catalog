import 'package:go_router/go_router.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/view/artwork_detail_screen.dart';
import 'package:chicago_art_catalog/features/artwork/presentation/view/artwork_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ArtworkListScreen(),
      routes: [
        GoRoute(
          path: 'artwork/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return ArtworkDetailScreen(artworkId: id);
          },
        ),
      ],
    ),
  ],
);