class SourceResponse {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  SourceResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory SourceResponse.fromJson(Map<String, dynamic> json) {
    return SourceResponse(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      category: json['category'] ?? '',
      language: json['language'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
