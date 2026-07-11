class TeamMemberModel {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;
  final String bio;
  final List<String> skills;
  final String? linkedInUrl;

  const TeamMemberModel({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.bio,
    required this.skills,
    this.linkedInUrl,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatarUrl'] as String,
      bio: json['bio'] as String,
      skills: List<String>.from(json['skills'] as List),
      linkedInUrl: json['linkedInUrl'] as String?,
    );
  }
}
