import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentacar/add_user_details_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:rentacar/dash_board_screen.dart';
import 'package:rentacar/login_screen.dart';





Future<void> main() async {

   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp( );
  // await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  DashBoardScreen()//
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("Welcome to MainActivity"),
      ),
    );
  }
}
