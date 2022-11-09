

import 'support_model.dart';
import 'user_model.dart';

class HelperModel {
  final int page, perPage, total, totalPages;
  final List<UserModel> data;
  final SupportModel support;

  HelperModel({
    required this.support,
    required this.data,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory HelperModel.fromJson(Map<String, dynamic> json) {
    return HelperModel(
      support: SupportModel.fromJson(json["support"]),
      data: (json["data"] as List)
          .map((item) => UserModel.fromJson(item))
          .toList(),
      page: json["page"] as int? ?? 0,
      perPage: json["per_page"] as int? ?? 0,
      total: json["total"] as int? ?? 0,
      totalPages: json["total_pages"] as int? ?? 0,
    );
  }
}
