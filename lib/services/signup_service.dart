import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/member_detail_model.dart';

Future<dynamic> validateBusiness(
    String b_no, String start_dt, String p_nm) async {
  String? serviceKey = dotenv.env['DATA_SERVICE_KEY'];

  final request = http.Request(
      'POST',
      Uri.parse(
          'http://api.odcloud.kr/api/nts-businessman/v1/validate?serviceKey=$serviceKey'));

  request.body = jsonEncode({
    {
      'b_no': b_no,
      'start_dt': start_dt,
      'p_nm': p_nm,
      'p_nm2': "",
      'b_nm': "",
      'corp_no': "",
      'b_sector': "",
      'b_type': "",
      'b_adr': "",
    }
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
    print(data);
    return MemberDetail.fromJson(data);
  } else {
    throw Exception('Failed to validate businiess number');
  }
}
