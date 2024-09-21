import 'package:flutter/material.dart';
import 'package:pop_up_the_local/models/member_detail_model.dart';
import 'package:pop_up_the_local/screens/boomark_screen.dart';
import 'package:pop_up_the_local/services/mypage_service.dart';
import 'package:pop_up_the_local/style/theme.dart';

import 'application_history_screen.dart';
import 'application_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MypageState();
}

class _MypageState extends State<MyPageScreen> {
  MemberDetail? member;

  @override
  void initState() {
    super.initState();
    _fetchMember();
  }

  void _fetchMember() async {
    var fetchedMember = await getMemberDetail();
    setState(() {
      member = fetchedMember;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 266, // 상단 배경 높이 조정
                color: ColorTheme.background, // 원하는 색상
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      if (member != null)
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(member!.image!), // 프로필 이미지 URL
                        ),
                      SizedBox(height: 10),
                      if (member != null)
                        Text(
                          member!.name!, // 사용자 이름
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xffF2F2F7),
                ),
              ),
            ],
          ),
          Positioned(
            top: 230, // 상자를 원하는 위치로 조정
            left: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20, // 왼쪽에 추가할 공간
                      ),
                      Text(
                        '계정 이메일',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      if (member != null)
                        Text(
                          member!.email!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20, // 왼쪽에 추가할 공간
                      ),
                      Text(
                        '회원 구분',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      if (member != null)
                        Text(
                          member!.role! == 'SELLER' ? '사업자 회원' : '일반 회원',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 340, // 상자를 원하는 위치로 조정
            left: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 16, // 왼쪽에 추가할 공간
                      ),
                      const Icon(
                        Icons.bookmark,
                        color: Color(0xff9DC284),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 8.0)),
                      Text(
                        '북마크',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: onNavigateBookmark,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16, // 왼쪽에 추가할 공간
                      ),
                      const Icon(
                        // 제출 아이콘
                        Icons.assignment,
                        color: Color(0xff9DC284),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 8.0)),
                      Text(
                        '팝업 등록 신청',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: onNavigateApplication,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16, // 왼쪽에 추가할 공간
                      ),
                      const Icon(
                        Icons.list_alt_rounded,
                        color: Color(0xff9DC284),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 8.0)),
                      Text(
                        '팝업 등록 현황',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: onNavigateApplicationHistory,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 550, // 상자를 원하는 위치로 조정
            left: MediaQuery.of(context).size.width / 2 - 126,
            child: Container(
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
              height: 50,
              width: 252,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: ColorTheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '계정 정보 수정',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onNavigateBookmark() {
    // TODO: 북마크 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookmarkScreen()),
    );
  }

  void onNavigateApplication() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApplicationScreen()),
    );
  }

  void onNavigateApplicationHistory() {
    // TODO: 팝업 등록 현황으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApplicationHistoryScreen()),
    );
  }
}
