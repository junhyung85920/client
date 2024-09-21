import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpBusinessScreen extends StatefulWidget {
  const SignUpBusinessScreen({super.key});

  @override
  State<SignUpBusinessScreen> createState() => _SignUpBusinessScreenState();
}

class _SignUpBusinessScreenState extends State<SignUpBusinessScreen> {
  final TextEditingController _businessNumberController =
      TextEditingController();
  final TextEditingController _representativeNameController =
      TextEditingController();
  final TextEditingController _openingDateController = TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  String apiKey =
      'UgFoStmmWS/SCQllXGxcp2NeqwmCXSp2dNa7dez/xXNRLkswkYDW3H8xGKSJESwaHG0K0aH5PLt7cmSOeBv61g==';
  String registerCheck = 'Failed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("사업자 정보"),
            TextField(
              controller: _businessNumberController,
              decoration: InputDecoration(
                labelText: "사업자 등록 번호",
                hintText: "사업자 등록 번호를 입력하세요",
              ),
            ),
            TextField(
              controller: _representativeNameController,
              decoration: InputDecoration(
                labelText: "대표자 성명",
                hintText: "대표자의 성명을 입력하세요",
              ),
            ),
            TextField(
              controller: _openingDateController,
              decoration: InputDecoration(
                labelText: "개업일자",
                hintText: "개업일자를 입력하세요",
              ),
            ),
            TextField(
              controller: _businessAddressController,
              decoration: InputDecoration(
                labelText: "사업장 주소",
                hintText: "사업장 주소를 입력하세요",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var result = await _confirmBusinessInfo();
                setState(() {
                  registerCheck = result;
                });
              },
              child: Text("확인"),
            ),
            registerCheck != 'Success'
                ? SizedBox(height: 40)
                : Column(
                    children: [
                      SizedBox(height: 40),
                      Text("추가 정보"),
                      TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: "전화 번호",
                          hintText: "전화 번호를 입력하세요",
                        ),
                      ),
                      TextField(
                        controller: _businessNameController,
                        decoration: InputDecoration(
                          labelText: "사업 명",
                          hintText: "사업 명을 입력하세요",
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("제출"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<String> _confirmBusinessInfo() async {
    String requestUrl =
        'http://api.odcloud.kr/api/nts-businessman/v1/validate?serviceKey=$apiKey&returnType=JSON';
    print("사업자 등록 번호: ${_businessNumberController.text}");
    print("대표자 성명: ${_representativeNameController.text}");
    print("개업일자: ${_openingDateController.text}");

    // request 데이터 생성
    // 요청할 JSON 데이터 구조 생성
    Map<String, dynamic> requestBody = {
      "businesses": [
        {
          "b_no": _businessNumberController.text, // 사업자 등록 번호
          "start_dt": _openingDateController.text, // 개업 일자
          "p_nm": _representativeNameController.text, // 대표자 성명
          "p_nm2": "", // 대표자 성명
          "b_nm": "", // 사업체 명칭 (필요하다면 입력)
          "corp_no": "", // 법인 번호 (필요하다면 입력)
          "b_sector": "", // 업종 (필요하다면 입력)
          "b_type": "", // 업태 (필요하다면 입력)
          "b_adr": "" // 주소 (필요하다면 입력)
        }
      ]
    };

    try {
      // POST 요청 전송
      var response = await http.post(Uri.parse(requestUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody));

      // 상태 코드가 200 OK인 경우, 응답을 처리
      if (response.statusCode == 200) {
        var data = (jsonDecode(response.body)['data'] as List)[0]['valid'];
        print(data); // 응답 데이터 출력 또는 다른 처리

        if (data == '01') {
          print("사업자 정보가 확인되었습니다.");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('사업자 정보가 확인되었습니다.'),
            duration: Duration(milliseconds: 500),
          ));

          return 'Success';
        } else {
          // 요청 실패 처리
          print('Failed to load data: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('사업자 정보가 확인되지 않았습니다.'),
            duration: Duration(milliseconds: 500),
          ));
          return 'Failed';
        }
      } else {
        // 요청 실패 처리
        print('Failed to load data: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('사업자 정보가 확인되지 않았습니다.'),
          duration: Duration(milliseconds: 500),
        ));
        return 'Failed';
      }
    } catch (e) {
      print('API error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('확인 중 오류가 발생했습니다.'),
        duration: Duration(milliseconds: 500),
      ));
      return 'Error';
    }
  }

  void _submitForm() {
    // 폼 제출 로직
    print("폼 데이터를 제출합니다.");
    print("사업자 등록 번호: ${_businessNumberController.text}");
    print("대표자 성명: ${_representativeNameController.text}");
    print("개업일자: ${_openingDateController.text}");
    print("사업장 주소: ${_businessAddressController.text}");
    print("전화 번호: ${_phoneNumberController.text}");
    print("사업 명: ${_businessNameController.text}");
  }
}
