import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DashBoardScreen.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  _PreLoginScreenState createState() {
    return _PreLoginScreenState();
  }
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Future<User?> _signInWithGoogle() async {
    // try {
    //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    //   if (googleUser == null) {
    //     // User cancelled the sign-in
    //     return null;
    //   }
    //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //   final UserCredential userCredential = await _auth.signInWithCredential(credential);
    //   return userCredential.user;
    // } catch (e) {
    //   // Optionally handle the error
    //   print('Error during Google sign-in: $e');
    //   return null;
    // }
 // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            FadeInRight(duration: Duration(seconds: 1),child: Image.asset('assets/images/tesla_1.png')),
            const SizedBox(height: 200),
            InkWell(
              onTap: ()  {
                // User? user = await _signInWithGoogle();
                // if (user != null) {
                //   print("Successfully signed in: ${user.displayName}");
                //   // Navigate to another screen or show signed-in state
                //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
                // } else {
                //   // Handle the case where the user did not sign in
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Failed to sign in with Google')),
                //   );
                // }
              },
              child: SizedBox(
                width: 250,
                child: FadeInUp(duration: Duration(seconds: 1),
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Padding(
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
                },
              child: SizedBox(
                width: 250,
                child: FadeInUp(duration: Duration(seconds: 1),
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Padding(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.user, color: Colors.blueGrey),
                          const SizedBox(width: 10), // Add space between the icon and text
                          const Text(                          'Login With Username',
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
    );
  }
}
