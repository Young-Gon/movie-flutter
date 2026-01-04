import 'package:domain/model/MediaModel.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/screen/detail/detail_screen.dart';
import 'package:presentation/screen/detail/detail_view_model.dart';
import 'package:presentation/screen/home/home_screen.dart';
import 'package:presentation/screen/home/tabs/movie_tab.dart';
import 'package:presentation/screen/home/tabs/movie_view_model.dart';
import 'package:presentation/screen/home/tabs/search_tab.dart';
import 'package:presentation/screen/home/tabs/tv_tab.dart';
import 'package:provider/provider.dart';

import '../main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/movie',
  routes: [
    // 1. 탭 상태(스크롤 등)를 유지하기 위한 ShellRoute
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(state: state, navigationShell: navigationShell);
      },
      branches: [
        // 각 탭의 스크롤 위치 등은 이 Branch 내부에서 유지됩니다.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/movie',
              builder: (context, state) => Provider<MovieViewModel>(
                create: (_) => getIt<MovieViewModel>(),
                dispose: (_, vm) => vm.dispose(),
                child: const MovieTab(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/tv', builder: (context, state) => const TvTab()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchTab(),
            ),
          ],
        ),
      ],
    ),

    // 2. 상세 페이지 (탭 구조 밖으로 뺌)
    // 이렇게 하면 이동 시 BottomNavigationBar가 사라지고 화면 전체를 씁니다.
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final media = state.extra as MediaModel;
        return Provider<DetailViewModel>(
          create: (_) => getIt<DetailViewModel>(),
          dispose: (_, vm) => vm.dispose(),
          child: DetailScreen(media: media),
        );
      },
    ),
  ],
);
