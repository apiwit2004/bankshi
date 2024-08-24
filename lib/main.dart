import 'package:flutter/material.dart';
import 'pages/frame_1.dart';
import 'pages/frame_2.dart';
import 'pages/frame_3.dart';
import 'pages/frame_4.dart';
import 'pages/frame_5.dart';
import 'pages/frame_6.dart';
import 'pages/frame_7.dart';
import 'pages/frame_8.dart';
import 'pages/frame_9.dart';
import 'pages/frame_10.dart';
import 'pages/frame_11.dart';
import 'pages/frame_12.dart';
import 'pages/frame_13.dart';
import 'pages/frame_14.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Frame App',
      initialRoute: '/frame_1', // เริ่มที่หน้า login
      routes: {
        '/frame_1': (context) => Frame1(),
        '/frame_2': (context) => (ModalRoute.of(context)?.settings.arguments !=
                null)
            ? Frame2(
                username: ModalRoute.of(context)!.settings.arguments as String)
            : Frame2(username: ''),
        '/frame_3': (context) => Frame3(),
        '/frame_4': (context) => Frame4(),
        '/frame_5': (context) => Frame5(),
        '/frame_6': (context) => Frame6(),
        '/frame_7': (context) => Frame7(),
        '/frame_8': (context) => Frame8(),
        '/frame_9': (context) => Frame9(),
        '/frame_10': (context) => Frame10(),
        '/frame_11': (context) => Frame11(),
        '/frame_12': (context) => Frame12(),
        '/frame_13': (context) => Frame13(),
        '/frame_14': (context) => Frame14(
            username: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
