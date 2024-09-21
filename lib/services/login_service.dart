import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/login_model.dart';

Future<MemberModel> nativeGoogleSignIn() async {
  String webClientId = dotenv.env['WEB_CLIENT_ID']!;
  String iosClientId = dotenv.env['IOS_CLIENT_ID']!;
  String? baseUrl = dotenv.env['BASE_URL'];

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();

  final response = await http.post(Uri.parse('$baseUrl/api/auth/google-login'),
      body: jsonEncode({
        'display_name': googleUser!.displayName,
        'email': googleUser.email,
        'photo_url': googleUser.photoUrl,
        'id': googleUser.id,
      }),
      headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        jsonDecode(utf8.decode(response.bodyBytes))['data'];
    print(data);
    return MemberModel.fromJson(data);
  } else {
    throw Exception('Failed to load member detail');
  }
}
