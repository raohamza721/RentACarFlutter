


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentacar/dash_board_screen.dart';

class FaqScreeen extends StatelessWidget{

  @override

  Widget build(BuildContext context){

    return  Scaffold(
        appBar: AppBar(
          leading: InkWell(onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(userId: "")));
          },
              child: const Icon(Icons.arrow_back)),
          title: const Text('FAQs'),
        ),
        body: const Center(child:  Text("Welcome to My Showroom", )));
  }
}