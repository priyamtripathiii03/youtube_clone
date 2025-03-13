import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/home_page.dart';
import 'package:youtube_clone/screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Clone',
     routes: {
        '/': (context)=> SplashScreen(),
       'home':(context)=> YouTubeHome(),
     },
    );
  }
}
