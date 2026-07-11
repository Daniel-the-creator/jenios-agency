class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String description;
  final List<String> technologies;
  final String client;
  final String? liveUrl;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.technologies,
    required this.client,
    this.liveUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      client: json['client'] as String,
      liveUrl: json['liveUrl'] as String?,
    );
  }
}
