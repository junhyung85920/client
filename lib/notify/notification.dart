import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification(context) async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(initializationSettings,
      //알림 누를때 함수실행하고 싶으면
      onSelectNotification: (payload) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Text('새로운페이지'),
      ),
    );
  });
}

//2. 이 함수 원하는 곳에서 실행하면 알림 뜸
showNotification() async {
  // 안드로이드
  var androidDetails = AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high, // 중요도
    importance: Importance.max, // 중요도
    color: Color.fromARGB(255, 255, 0, 0), // 알림 색상
  );

  // ios
  var iosDetails = IOSNotificationDetails(
    presentAlert: true, // 알림 여부
    presentBadge: false, // 뱃지 여부
    presentSound: true, // 소리 여부
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(1, '팝업 오픈 알림', '원데이 비누 클래스(이)가 내일부터 시작합니다!',
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: '부가정보');
}
