import 'package:flutter/material.dart';
import 'package:movie/screens/home/tabs/MoviePage.dart';
import 'package:movie/screens/home/tabs/SearchPage.dart';
import 'package:movie/screens/home/tabs/TVPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabTitle = ["Movies", "TVs", "Search"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitle[_tabController.index]),
        centerTitle: true,
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.primary,
        child: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(),
          labelColor: Theme.of(context).colorScheme.onPrimary,
          unselectedLabelColor: Theme.of(
            context,
          ).colorScheme.onPrimary.withOpacity(0.7),
          tabs: [
            Tab(
              icon: Icon(
                _tabController.index == 0 ? Icons.movie : Icons.movie_outlined,
              ),
              text: 'Movie',
            ),
            Tab(
              icon: Icon(
                _tabController.index == 1
                    ? Icons.smart_display
                    : Icons.smart_display_outlined,
              ),
              text: 'TV',
            ),
            Tab(icon: const Icon(Icons.search), text: 'Search'),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          const MoviePage(),
          const Center(child: SearchPage()),
          const Center(child: TvPage()),
        ],
      ),
    );
  }
}
