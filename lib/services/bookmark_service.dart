import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/bookmark_model.dart';

Future<List<dynamic>> getBookmarkList(String memberId) async {
  String? baseUrl = dotenv.env['BASE_URL'];

  final response = await http.get(Uri.parse('$baseUrl/api/bookmarks'));
  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes))['data'];
    print(data);
    return data.map((e) => BookmarkModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load bookmark list');
  }
}
