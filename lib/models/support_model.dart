class SupportModel {
  final String url;
  final String text;

  SupportModel({
    required this.url,
    required this.text,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      url: json["url"] as String? ?? "",
      text: json["text"] as String? ?? "",
    );
  }
}
