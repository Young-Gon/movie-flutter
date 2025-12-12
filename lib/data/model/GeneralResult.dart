class GeneralResult<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  GeneralResult({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory GeneralResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return GeneralResult(
      page: json['page'],
      results: (json['results'] as List<Map<String, dynamic>>)
          .map((item) => fromJsonT(item))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
