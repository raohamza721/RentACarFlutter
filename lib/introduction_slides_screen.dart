import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rentacar/dash_board_screen.dart';
import 'package:rentacar/pre_login_screen.dart';

class IntroductionSlidesScreen extends StatelessWidget{
  const IntroductionSlidesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List <PageViewModel> pages = [
      PageViewModel(
        title: "Drive Your Dream" ,
        body: "Drive Your Dream: Rent the Perfect Car Today!",
        image:  Container(
             margin: const EdgeInsets.only(top: 200.0),
              width: 350,
              height: 350
              ,child: Lottie.asset('assets/LottieFiles/lottie1.json')),


      ),


      PageViewModel(

          title: "Experience Freedom" ,
          body: "One Click to Affordable Freedom!.",
          image:  Container(
          margin: const EdgeInsets.only(top: 200.0),
          width: 350,
          height: 350,
          child: Lottie.asset('assets/LottieFiles/lottie2.json')
    ) ),

    PageViewModel(

          title: "Journey in Style" ,
          body: "One Click to Stylish Journeys!",
          image:  Container(
          margin: const EdgeInsets.only(top: 200.0),
          width: 350,
          height: 350,
          child: Lottie.asset('assets/LottieFiles/lottie3.json')
          )),

    ];
    return  Scaffold(

      body: IntroductionScreen(
        pages: pages,
        showSkipButton: true,
        skip: const Text("Skip"),
        next : const Text("Next"),
        done: const Text("Done"),
        onDone: (){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => PreLoginScreen(),));
        },


      ),

    );
  }
}