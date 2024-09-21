import 'package:flutter/material.dart';
import 'package:pop_up_the_local/widgets/horizontal_show_widget.dart';

import '../style/theme.dart';
import '../widgets/recommended_store_info_widget.dart';
import '../widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 234,
                  color: ColorTheme.background,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 40),
                        Text('로컬 팝업',
                            style: Theme.of(context).textTheme.headlineLarge),
                      ],
                    ),
                  ),
                ),
                const TitleWidget(
                    title: '지금 떠오르는\n우리 동네 로컬 팝업', keyWord: '우리 동네'),
                const HorizontalShow(),
                const TitleWidget(
                  title: '유저가 직접 추천하는 곳',
                  keyWord: '유저',
                ),
                const RecommendedStoreInfoWidget(
                  location: '대구 수성구',
                  title: 'OO 스토어',
                  imagePath: 'assets/img/couple_date.png',
                  comment:
                      '기대를 안하고 갔는데 너무너무 맛있었던 곳입니다! 팝업이 끝나도 본 가게에 자주 가고 있어서 정말 추천합니다!',
                ),

                // 추천 팝업 목록
              ],
            ),
          )
        ],
      ),
    );
  }
}
