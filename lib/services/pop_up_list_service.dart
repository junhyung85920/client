import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/pop_up_model.dart';

class PopUpListService {
  String? apiUrl = dotenv
      .env['BASE_URL']; // Make sure this is correctly set in your .env file

  Future<dynamic> fetchPopUps(String? category, String? city) async {
    var url = '$apiUrl/api/popups/list';

    if (category != '전체' && category != null) {
      switch (category) {
        case '요식':
          category = 'FOOD';
          break;
        case '제조':
          category = 'MANUFACTUR';
          break;
        case '예술':
          category = 'ART';
          break;
        case '교육':
          category = 'EDU';
          break;
      }
      url += '?category=$category';

      if (city != '전체' && city != null) {
        url += '&city=$city';
      }
    } else {
      if (city != '전체' && city != null) {
        url += '?city=$city';
      }
    }

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        return data.map((e) => PopUpModel.fromJson(e)).toList();
      } else {
        print('Failed to load popups from the server');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');
      return [];
    }
  }
}
