import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/member_detail_model.dart';

Future<dynamic> getMemberDetail() async {
  String? baseUrl = dotenv.env['BASE_URL'];

  //final response = await http.get(Uri.parse('$baseUrl/api/members'));

  final Map<String, dynamic> data = {
    'email': 'popup@example.com',
    'role': 'SELLER',
    'image': 'https://avatars.githubusercontent.com/u/86557146?v=4',
    'name': '팝업더로컬',
  };
  print(data);
  return MemberDetail.fromJson(data);
}
