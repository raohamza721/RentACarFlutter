import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rentacar/dash_board_screen.dart';
import 'package:rentacar/login_screen.dart';

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

    final UserCredential userCredential = await _auth.signInWithCredential(
        credential);

    final User? user = userCredential.user;

    if (user != null) {
      String userId = user.uid; // Get the userID


      setState(() {
        _isLoading = false; // Stop loading
      });

      return userCredential.user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.grey],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: SizedBox(
                    height: 150,
                    width: 100,
                  ),
                ),
                FadeInRight(
                  duration: const Duration(seconds: 1),
                  child: Image.asset('assets/images/tesla_1.png'),
                ),
                const SizedBox(height: 100),
                // First button
                InkWell(
                  onTap: () async {
                    User? user = await _signInWithGoogle();
                    if (user != null) {
                      String userId = user.uid; // Capture the userId from the user object
                      debugPrint('Sign in successful: ${user.displayName}, UserId: $userId');

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashBoardScreen(userId: userId), // Pass the userId
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: 250,
                    child: FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Card(
                        elevation: 6,
                        // Increased elevation for a more pronounced shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // More rounded corners
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [Colors.redAccent, Colors.orangeAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.google,
                                    color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Login with Gmail',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Second button
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: SizedBox(
                    width: 250,
                    child: FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Card(
                        elevation: 6,
                        // Increased elevation for a more pronounced shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // More rounded corners
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [Colors.blueGrey, Colors.blueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                    FontAwesomeIcons.user, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Login With Username',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
              color: Colors.black54,
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