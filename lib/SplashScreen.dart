import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rentacar/DashBoardScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3),(){

     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(), ));

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Image.asset('assets/images/tesla_1.png'),
          ),
        ),
      ),
    );
  }
}