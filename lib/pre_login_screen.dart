import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rentacar/DashBoardScreen.dart';
import 'package:rentacar/LoginScreen.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  _PreLoginScreenState createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false; // Boolean to track loading state

  Future<User?> _signInWithGoogle() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);

    setState(() {
      _isLoading = false; // Stop loading
    });

    return userCredential.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey, // Set the background color here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the column content
              children: [
                const Center(
                  child: SizedBox(
                    height: 150,
                    width: 100,
                  ),
                ),
                FadeInRight(duration: const Duration(seconds: 1), child: Image.asset('assets/images/tesla_1.png')),
                const SizedBox(height: 100), // Reduced height
                InkWell(
                  onTap: () async {
                    User? user = await _signInWithGoogle();
                    if (user != null) {
                      debugPrint('Sign in successful: ${user.displayName}');
                      // Navigate to DashBoardScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const DashBoardScreen()),
                      );
                    }
                  },
                  child: SizedBox(
                    width: 250,
                    child: FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.google, color: Colors.red),
                              SizedBox(width: 10), // Add space between the icon and text
                              Text(
                                'Login with Gmail',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: SizedBox(
                    width: 250,
                    child: FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.user, color: Colors.blueGrey),
                              SizedBox(width: 10), // Add space between the icon and text
                              Text(
                                'Login With Username',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54, // Semi-transparent background
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
