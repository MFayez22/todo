import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants/colors/colors.dart';
import 'package:todo/screens/splash_screen.dart';

import 'network/local/cache_helper.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();


  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  bool isEnglish1 = sharedPreferences.getBool('isEnglish') ?? true;
  await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
            channelKey: 'taskKey',
            channelName: 'Task',
            channelDescription: 'todo app for task',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          )
      ],);

  CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: primaryColor2,
          timePickerTheme: TimePickerThemeData(
            helpTextStyle: TextStyle(fontFamily: 'Righteous-Regular',color: shadowColor),
            dayPeriodTextStyle:TextStyle(fontFamily: 'Righteous-Regular',color: shadowColor) ,
            dialTextColor: shadowColor,

            hourMinuteTextColor: shadowColor,
            backgroundColor: defaultColor
          ),
          fontFamily: 'Pacifico-Regular'),
      home: const SplashScreen(),
    );
  }
}
