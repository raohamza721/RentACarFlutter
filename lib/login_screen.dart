import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentacar/create_account_screen.dart';
import 'package:rentacar/dash_board_screen.dart';
import 'package:rentacar/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // To track the loading state
  bool _isLoading = false;

  // Function to handle user login
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      if (user != null) {
        String userId = user.uid; // Get the userID

        // Navigate to DashboardScreen and pass the userID
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoardScreen(userId: userId),
          ),
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = 'Login failed. Please try again.';
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3E3E3E), Color(0xFF2B2B2B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 80,
                      left: 20,
                      right: 20,
                      child: Card(
                        color: const Color(0xFF424242),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/images/profile.png',
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF3E3E3E)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFF3E3E3E)),
                                ),
                              ),
                              child: TextField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Your Email",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: GestureDetector(
                        onTap: _login,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6D6D6D), Color(0xFF3E3E3E)],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Color(0xFF6D6D6D)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) => const CreateAccountScreen()),
                          );
                        },
                        child: const Text(
                          "Didn't have an account? Register",
                          style: TextStyle(color: Color(0xFF6D6D6D)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}