import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pop_up_the_local/screens/application_screen.dart';
import 'package:pop_up_the_local/screens/home_screen.dart';
import 'package:pop_up_the_local/screens/pop_up_detailed_screen.dart';
import 'package:pop_up_the_local/screens/pop_up_list_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pop_up_the_local/screens/sign_up_customer_screen.dart';
import 'notify/notification.dart';
import 'screens/boomark_screen.dart';
import 'screens/sign_up_business_screen.dart';

import 'screens/image_upload_screen.dart';
import 'screens/my_page_screen.dart';
import 'style/theme.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  await initializeDateFormatting();

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness:
          Brightness.light // Dark == white status bar -- for IOS.
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentBottomNavIndex = 0;

  static const List<Widget> _screenList = [
    HomeScreen(),
    // PopUpDetailedScreen(),
    PopUpListScreen(),
    //SignUpBusinessScreen(),
    //ApplicationScreen(),
    //ImageUploadScreen(),
    MyPageScreen(),
    //SignUpCustomerScreen(),
    //BookmarkScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() => _currentBottomNavIndex = index);
  }

  Future<bool> _onWillPop() async {
    if (_currentBottomNavIndex != 0) {
      setState(() => _currentBottomNavIndex = 0);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();
    initNotification(context);
    showNotification();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignUpBusinessScreen());
  }
}
