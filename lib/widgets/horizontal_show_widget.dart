// this is widget for horizontal show of the items

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pop_up_the_local/notify/notification.dart';
import 'package:pop_up_the_local/screens/pop_up_detailed_screen.dart';
import '../services/pop_up_list_service.dart';
import '../style/theme.dart';

class HorizontalShow extends StatefulWidget {
  const HorizontalShow({super.key});

  @override
  State<HorizontalShow> createState() => _HorizontalShowState();
}

class _HorizontalShowState extends State<HorizontalShow> {
  List<dynamic> popUps = [];
  final PopUpListService _popUpListService = PopUpListService();

  @override
  void initState() {
    super.initState();
    _fetchPopUps();
  }

  void _fetchPopUps() async {
    var fetchedPopUps = await _popUpListService.fetchPopUps(null, null);
    setState(() {
      popUps = fetchedPopUps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popUps.length,
        itemBuilder: (context, index) {
          var popup = popUps[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PopUpDetailedScreen(
                        popupId: popup.popup_id,
                      ),
                    ),
                  );
                  showNotification();
                },
                child: Column(
                  children: [
                    Container(
                        width: 140,
                        height: 160,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: ColorTheme.background,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(popup.image), // 팝업 대표 이미지
                            fit: BoxFit.cover,
                          ),
                        )),
                    Text(
                      popup.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis, // 팝업 위치
                    ),
                    Text(popup.address,
                        style: Theme.of(context).textTheme.titleSmall), // 팝업 이름
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
