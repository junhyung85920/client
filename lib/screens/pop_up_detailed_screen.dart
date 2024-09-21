import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pop_up_the_local/services/popup_service.dart';
import 'package:pop_up_the_local/style/theme.dart';
import 'package:pop_up_the_local/widgets/horizontal_show_widget.dart';
import 'package:pop_up_the_local/widgets/title_widget.dart';

class PopUpDetailedScreen extends StatefulWidget {
  const PopUpDetailedScreen({super.key, required this.popupId});

  final String popupId;

  @override
  State<PopUpDetailedScreen> createState() => _PopUpDetailedScreenState();
}

class _PopUpDetailedScreenState extends State<PopUpDetailedScreen> {
  bool _isBookmarked = false;
  bool _isExpanded = false;
  dynamic popUp = {};
  List<dynamic> images = [];

  @override
  void initState() {
    super.initState();
    _fetchPopUp();
  }

  void _fetchPopUp() async {
    var fetchedPopUp = await getPopupDetail(widget.popupId);
    setState(() {
      popUp = fetchedPopUp;
      images = popUp['images'] ?? ['default'];
      _isBookmarked = popUp['bookmark_id'] ?? false;
    });
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleBookmark() {
    if (_isBookmarked) {
      deleteBookmark((popUp['bookmark_id']) ?? 'default');
    } else {
      createBookmark(popUp['popup_id']);
    }

    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? '북마크 설정됨' : '북마크 해제됨'),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 팝업 상세 페이지
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (images.isNotEmpty)
                  Container(
                    height: 243,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(images[0]), fit: BoxFit.cover),
                    ),
                  ),
                // 팝업 상세 정보
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  height: 150,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    popUp['title'] ?? 'default',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 10),
                                  // Text(popUp['address'],
                                  //     style: const TextStyle(
                                  //         color: Colors.grey,
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w500),
                                  //     overflow: TextOverflow.ellipsis),
                                ],
                              ),
                              // Text.rich(
                              //   TextSpan(
                              //     text: popUp['title'],
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .headlineMedium,
                              //     children: [
                              //       // 빈칸 넣기
                              //       TextSpan(text: '  '),
                              //       TextSpan(
                              //           text: popUp['address'],
                              //           style: TextStyle(
                              //               color: Colors.grey,
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w500)),
                              //       // style:
                              //       //     Theme.of(context).textTheme.bodyMedium),
                              //     ],
                              //   ),
                              // ),
                              IconButton(
                                onPressed: _toggleBookmark,
                                icon: Icon(
                                  _isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: ColorTheme.background,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '${popUp['start_date']} ~ ${popUp['end_date']}',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('장소: ${popUp['address']}',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  //padding: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.3),
                      //bottom: BorderSide(color: Colors.grey, width: 0.3),
                    ),
                  ),
                  child: Text(
                    popUp['description'] ?? 'default',
                    style: Theme.of(context).textTheme.bodyMedium,
                    //qwqwwqoverflow: TextOverflow.ellipsis,
                    maxLines: 50,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  // get size of _buildImageCard() and multiply by number of images
                  // set height as reactive to the number of images
                  height: _isExpanded ? 410 * images.length.toDouble() : 410,

                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.3)),
                  ),
                  child: _isExpanded
                      ? GridView.count(
                          padding: const EdgeInsets.all(20),
                          scrollDirection: Axis.vertical,
                          mainAxisSpacing: 10, // 이미지 사이의 간격
                          crossAxisCount: 1, // 노출 이미지 수
                          shrinkWrap: true, // 스크롤 가능 여부
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(images.length, (index) {
                            return _buildImageCard(images[index]);
                          }),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.all(20),
                          scrollDirection: Axis.vertical,
                          mainAxisSpacing: 10,
                          crossAxisCount: 1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(images.length, (index) {
                            return _buildImageCard(images[index]);
                          }),
                        ),
                ),
                GestureDetector(
                  onTap: _toggleExpand,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isExpanded ? '접기' : '더보기',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),
                const TitleWidget(title: "유사한 동네 팝업", keyWord: "유사한 동네 팝업"),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: CupertinoTextField(
                //     placeholder: '댓글을 입력하세요',
                //     padding: const EdgeInsets.all(20),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(color: Colors.grey),
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     suffix: Padding(
                //       padding: const EdgeInsets.only(right: 10),
                //       child: IconButton(
                //         onPressed: () {
                //           // 밥 먹고 와서 creat Comment 함수 만들어야 함
                //         },
                //         icon: Icon(
                //           Icons.send,
                //           color: ColorTheme.background,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                const HorizontalShow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.all(0),
      child: Image(
        image: NetworkImage(imagePath),
        fit: BoxFit.cover,
      ),
    );
  }
}
