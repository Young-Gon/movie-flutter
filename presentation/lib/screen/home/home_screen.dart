import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final GoRouterState state;
  final StatefulNavigationShell navigationShell;
  static const List<String> tabTitle = ["Movies", "TVs", "Search"];

  const HomeScreen({
    super.key,
    required this.state,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitle[navigationShell.currentIndex]),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          // 1. 탭 이동 수행
          navigationShell.goBranch(index);

          // 2. 필요하다면 전역 상태 ViewModel 등에 현재 탭 정보를 알려줌 (MVI Intent)
          // context.read<MainViewModel>().dispatch(ChangeTabIntent(index));
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: tabTitle[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_display_outlined),
            activeIcon: Icon(Icons.smart_display),
            label: tabTitle[1],
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: tabTitle[2]),
        ],
      ),
      body: navigationShell,
    );
  }
}
