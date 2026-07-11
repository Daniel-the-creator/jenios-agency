class TestimonialModel {
  final String id;
  final String name;
  final String avatarUrl;
  final double rating;
  final String review;
  final String position;

  const TestimonialModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.review,
    required this.position,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String,
      position: json['position'] as String,
    );
  }
}

class JourneyMilestone {
  final String year;
  final String title;
  final String description;

  const JourneyMilestone({
    required this.year,
    required this.title,
    required this.description,
  });
}

class StatItem {
  final String value;
  final String label;
  final int targetNumber;

  const StatItem({
    required this.value,
    required this.label,
    required this.targetNumber,
  });
}
