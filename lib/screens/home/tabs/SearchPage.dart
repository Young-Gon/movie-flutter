import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/component/ErrorScreen.dart';
import 'package:movie/component/MediaItem.dart';

import '../../../data/provider/seach_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 검색어와 검색 결과를 각각 watch합니다.
    final query = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search movies and TV shows',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                gapPadding: 8.0,
              ),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              // 키패드의 'search' 버튼을 누르면 검색어 Provider의 상태를 업데이트합니다.
              ref.read(searchQueryProvider.notifier).state = value;
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            // 검색어가 비어있으면 초기 안내 메시지를, 그렇지 않으면 검색 결과를 표시합니다.
            child: query.isEmpty
                ? const Center(
                    child: Text('Please enter a search term to begin.'),
                  )
                : searchResults.when(
                    data: (data) {
                      final movies = data.$1.results;
                      final tvs = data.$2.results;
                      final allMedia = [...movies, ...tvs];

                      if (allMedia.isEmpty) {
                        // 검색 결과가 없을 때 메시지를 표시합니다.
                        return const Center(child: Text('No results found.'));
                      }

                      return ListView.separated(
                        itemCount: allMedia.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          return MediaItem(media: allMedia[index]);
                        },
                      );
                    },
                    error: (error, stack) {
                      print(error.toString());
                      return const ErrorScreen();
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
          ),
        ],
      ),
    );
  }
}
