import 'package:calc_app_with_provider/view/home_page_view.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageView(),
    );
  }
}