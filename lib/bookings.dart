
import 'package:flutter/material.dart';
import 'package:rentacar/dash_board_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});


  @override

  Widget build(BuildContext context)
  {
    return  Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(userId: "")));
        },
            child: const Icon(Icons.arrow_back)),
        title: const Text('Bookings'),
      ),

      body: Text(
        "Welcom to booking screen"
      ),
    );
  }
}