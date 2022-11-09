import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as https;
import 'package:shimmer_example/models/helper_model.dart';

class UsersApiService {
  static Future<HelperModel> getUsers() async {
    try {
      Response response = await https
          .get(Uri.parse("https://reqres.in/api/users/?per_page=12"));
      if (response.statusCode == 200) {
        HelperModel users = HelperModel.fromJson(jsonDecode(response.body));
        return users;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
