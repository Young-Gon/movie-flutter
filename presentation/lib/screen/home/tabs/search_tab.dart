import 'package:domain/model/MediaModel.dart';
import 'package:flutter/material.dart';
import 'package:presentation/screen/home/tabs/search_view_model.dart';
import 'package:provider/provider.dart';

import '../../../component/ErrorScreen.dart';
import '../../../component/MediaItem.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<SearchState>(
          stream: viewModel.state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            final query = state?.query ?? '';
            final results = state?.results;
            // ViewModel의 상태로부터 현재 선택된 미디어 타입을 가져옵니다. (기본값: 'movie')
            final selectedMediaType = state?.mediaType ?? MediaType.movie;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 미디어 타입 선택을 위한 DropdownButton
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<MediaType>(
                            value: selectedMediaType,
                            items: const [
                              DropdownMenuItem(
                                value: MediaType.movie,
                                child: Text('Movie'),
                              ),
                              DropdownMenuItem(
                                value: MediaType.tv,
                                child: Text('TV'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                // ViewModel에 미디어 타입 변경 Intent를 전달합니다.
                                viewModel.onIntent(SetMediaType(value));
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search movies and TV shows',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32),
                              ),
                              gapPadding: 8.0,
                            ),
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            viewModel.onIntent(Search(value));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _buildResults(
                      state?.isLoading ?? false,
                      query.isEmpty,
                      state?.error != null,
                      results,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildResults(
    bool isLoading,
    bool queryIsEmpty,
    bool isError,
    List<MediaModel>? results,
  ) {
    if (queryIsEmpty) {
      return const Center(child: Text('Please enter a search term to begin.'));
    }
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (results == null || results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }
    if (isError) {
      return const ErrorScreen();
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return MediaItem(media: results[index]);
      },
    );
  }
}
