import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/home_page.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> YouTubeHome()));
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 400),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/youtube logo.png'),
                  ),
                ),
              ),
            ),
            const Text("YouTube Clone",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}