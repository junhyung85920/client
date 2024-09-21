import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pop_up_the_local/widgets/custom_progress_ring_widget.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_white_widget.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_widget.dart';
import 'package:pop_up_the_local/widgets/text_input_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

import '../services/image_service.dart';
import '../style/theme.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  double _progress = 0.0;
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedLocation = '전체';
  String _selectedIndustry = '전체';
  String? apiUrl = dotenv.env['BASE_URL'];

  @override
  void initState() {
    super.initState();
    _storeNameController.addListener(_updateProgress);
    _descriptionController.addListener(_updateProgress);
    _selectedLocation = '전체';
    _selectedIndustry = '전체';
  }

  void _updateProgress() {
    double newProgress = 0.0;
    if (_storeNameController.text.isNotEmpty) newProgress += 0.2;
    if (_descriptionController.text.isNotEmpty) newProgress += 0.2;
    if (_selectedLocation != '전체') newProgress += 0.2;
    if (_selectedIndustry != '전체') newProgress += 0.2;
    if (_selectedDay != DateTime.now()) newProgress += 0.2;

    setState(() {
      print(newProgress);
      _progress = newProgress;
    });
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _selectedLocation = '전체';
    _selectedIndustry = '전체';
    super.dispose();
  }

  final List<String> _industries = <String>[
    '전체',
    '요식',
    '제조',
    '예술',
    '교육',
  ];

  final List<String> _locations = <String>[
    '전체',
    '서울',
    '경기',
    '인천',
    '부산',
    '대구',
    '울산',
    '광주',
    '대전',
    '세종',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주도'
  ];

  List<XFile>? _selectedImages;

  void _pickImages() async {
    var images = await ImagePickerService().pickImage();
    setState(() {
      _selectedImages = images;
    });
  }

  Future<String> _getRecommendation() async {
    // 서버 URL 변경 필요

    Map<String, dynamic> requestBody = {
      "description": _descriptionController.text,
    };

    // 서버 요청 및 응답 처리
    var response = await http.post(
        Uri.parse('$apiUrl/api/application/recommendation'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      // JSON 파싱
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      // content 값을 List<String>으로 변환하여 반환
      List<dynamic> contents = data['data']['content'];
      List<String> contentList =
          List<String>.from(contents.map((item) => item.toString()));
      //print((jsonDecode(utf8.decode(response.bodyBytes))['data']));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('추천 성공!')));
      print(jsonDecode(utf8.decode(response.bodyBytes))['data']['content']);
      return contentList.toString();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('추천 실패!')));
      return '추천 실패!';
    }
  }

  Future<void> _uploadImages() async {
    var uri = Uri.parse('YOUR_BACKEND_URL'); // 서버 URL
    var request = http.MultipartRequest('POST', uri);

    for (var image in _selectedImages!) {
      var multipartFile = await http.MultipartFile.fromPath(
        'picture', // 백엔드에서 기대하는 필드 이름
        image.path,
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded successfully!');
    } else {
      print('Upload failed!');
    }
  }

  Future<void> _submitData() async {
    var uri = Uri.parse('$apiUrl/api/application'); // 서버 URL 변경 필요
    var request = http.MultipartRequest('POST', uri);

    DateTime endDate = _selectedDay.add(const Duration(days: 4));

    // 기타 정보 추가
    request.fields['title'] = _storeNameController.text;
    request.fields['address'] = '$_selectedLocation,청호로,12345';
    request.fields['category'] = 'FOOD';
    request.fields['description'] = _descriptionController.text;
    request.fields['startDate'] =
        _selectedDay.toString().substring(0, 10); // 예: 2023-01-01 형식으로 변경 필요
    request.fields['endDate'] =
        endDate.toString().substring(0, 10); // 예: 2023-01-01 형식으로 변경 필요

    // 이미지 파일 추가
    if (_selectedImages != null) {
      for (var image in _selectedImages!) {
        var multipartFile = await http.MultipartFile.fromPath(
          'images', // 백엔드에서 기대하는 필드 이름
          image.path,
        );
        request.files.add(multipartFile);
      }
      print('Images added!');
    }

    print(request.fields);
    print(request.files);

    // 서버 요청 및 응답 처리
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Submitted successfully!');
    } else {
      print(response.statusCode);
      print('Submit failed!');
    }
  }

  String? recommendation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 234,
            color: ColorTheme.background,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomProgressRingWidget(
                      size: 80,
                      backgroundColor: ColorTheme.background,
                      progressColor: Colors.white,
                      strokeWidth: 8.0,
                      progress: _progress,
                    ),
                    const SizedBox(width: 40),
                    Text('팝업 신청하기',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 600,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomDropdownWhiteWidget(
                        title: '업종',
                        categories: _industries,
                        selectedValue: _selectedIndustry,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedIndustry = newValue!;
                            _updateProgress();
                          });
                        },
                      ),
                      CustomDropdownWhiteWidget(
                        title: '장소',
                        categories: _locations,
                        selectedValue: _selectedLocation,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue!;
                            _updateProgress();
                          });
                        },
                      ),
                    ],
                  ),
                  TextInputWidget(
                      title: '가게 이름',
                      hintText: '가게 이름을 입력해주세요',
                      controller: _storeNameController,
                      onTextChanged: _updateProgress),
                  TextInputWidget(
                      title: '내용',
                      hintText: '내용을 입력해주세요',
                      controller: _descriptionController,
                      onTextChanged: _updateProgress),
                  const SizedBox(height: 20),
                  buildCalendar(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var data = await _getRecommendation();
                      setState(() => recommendation = data);
                      // recommendation의 첫 글자, 마지막 글자 제거
                      recommendation = recommendation!
                          .substring(1, recommendation!.length - 1);
                      recommendation = '[ChatGPT의 추천 한마디!]\n${recommendation!}';
                    },
                    child: const Text('팝업 이벤트 추천'),
                  ),
                  if (_selectedImages != null)
                    Wrap(
                      children: _selectedImages!.map((file) {
                        return Image.file(File(file.path),
                            width: 100, height: 100);
                      }).toList(),
                    ),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _pickImages,
                          child: const Text('사진 선택'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitData();
                            // 이전 화면으로 이동
                            Navigator.pop(context);
                          },
                          child: const Text('제출하기'),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  // recommendation이 null이 아닐 때만 Container 표시
                  if (recommendation != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ColorTheme.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        primary: false,
                        controller: ScrollController(),
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            color: ColorTheme.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            recommendation ?? 'default',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCalendar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        locale: 'ko_KR',
        daysOfWeekHeight: 30,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          // 선택한 날짜를 저장하고 화면을 갱신합니다.
          // selectedDay를 yyyy-MM-dd 형태로 출력
          print(selectedDay.toString().substring(0, 10));

          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
            _updateProgress();
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: ColorTheme.background,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          formatButtonShowsNext: false,
        ),
      ),
    );
  }
}
