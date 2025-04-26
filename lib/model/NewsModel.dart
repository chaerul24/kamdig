class NewsModel {
  final String id;
  final String title;
  final String image;
  final String artikel;
  final String comment;
  final String views;
  final String postedBy;
  final String createdAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.artikel,
    required this.comment,
    required this.views,
    required this.postedBy,
    required this.createdAt,
  });

  factory NewsModel.fromJson(String id, Map<String, dynamic> json) {
    return NewsModel(
      id: id,
      title: json['title'],
      image: json['image'],
      artikel: json['artikel'],
      comment: json['comment'],
      views: json['views'],
      postedBy: json['posted_by'],
      createdAt: json['create_at'],
    );
  }
}
