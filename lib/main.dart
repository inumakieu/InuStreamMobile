import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inu_stream_ios/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Inu's Stream",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}
