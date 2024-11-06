class FeedBackModel {
  final String id;
  final String description;

  FeedBackModel({
    required this.id,
    required this.description,
  });

  factory FeedBackModel.fromMap(Map<String, dynamic> data, String documentId) {
    return FeedBackModel(
      id: documentId,
      description: data['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
    };
  }

  factory FeedBackModel.fromJson(Map<String, dynamic> json, String docId) {
    return FeedBackModel(
      id: docId,
      description: json['description'],
    );
  }
}
