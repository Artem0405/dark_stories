class Story {
  final int id;
  final String title;
  final String endingText;
  final String solutionText;
  final int difficulty;
  final String category;
  final List<String> hints;
  final bool isFree;

  Story({
    required this.id,
    required this.title,
    required this.endingText,
    required this.solutionText,
    required this.difficulty,
    required this.category,
    required this.hints,
    required this.isFree,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'],
      endingText: json['ending_text'], // Обрати внимание на snake_case
      solutionText: json['solution_text'],
      difficulty: json['difficulty'],
      category: json['category'],
      hints: List<String>.from(json['hints']),
      isFree: json['is_free'],
    );
  }
}