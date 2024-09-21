import 'package:flutter/material.dart';
import 'package:pop_up_the_local/services/bookmark_service.dart';
import 'package:pop_up_the_local/style/theme.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _isBookmarked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('북마크'),
        ),
        body: Container(
            color: Colors.white,
            child: FutureBuilder(
                future: getBookmarkList("66c68f2bfdd2695f92702262"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              minVerticalPadding: 10.0,
                              leading: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(8.0), // 원하는 반경 값으로 설정
                                child: Image.network(
                                  snapshot.data![index].image,
                                  width: 70,
                                  height: 80,
                                  fit: BoxFit.cover, // 이미지가 잘리지 않도록 설정
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text(
                                    snapshot.data![index].description, // 설명 텍스트
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${snapshot.data![index].start_date} ~ ${snapshot.data![index].end_date}', // 기간 날짜 텍스트
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _isBookmarked = !_isBookmarked;
                                  setState(() {});
                                  _onPressBookmark();
                                },
                                icon: Icon(
                                  _isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: ColorTheme.background,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              onTap: () {
                                // 아이템 클릭 시 동작
                                print(
                                    'Tapped on ${snapshot.data![index].title}');
                              },
                            ),
                            Divider(
                              color: const Color.fromARGB(37, 73, 73, 73),
                              thickness: 1.0,
                              indent: 16.0,
                              endIndent: 16.0,
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })));
  }

  void _onPressBookmark() {
    // TODO: 북마크 추가/삭제 기능 구현
  }
}
