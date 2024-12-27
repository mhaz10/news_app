class Article {
  late final String title;
  late final String imageUrl;
  late final String articleUrl;

  Article({
    required this.title,
    required this.imageUrl,
    required this.articleUrl,
  });

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
      title: jsonData['title'] ?? '',
      imageUrl: jsonData['urlToImage'] ?? '',
      articleUrl: jsonData['url'] ?? '',
    );
  }
}
