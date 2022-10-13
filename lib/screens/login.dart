import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/signup.dart';

class Login extends StatefulWidget {
  //const Login({super.key});
  final TabController tabController;
  @override
  State<Login> createState() => _LoginState();
  Login({required this.tabController});
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'SignIn into your\nAccount',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }
                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        //isDense: true,
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        // labelText: 'Email',
                        hintText: 'johndoe@gmail.com',
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Colors.red,
                        ),
                        //  errorText: _isloginsuccessful
                        // ? null
                        // : _usernameerrormessage,
                        // errorStyle: TextStyle(height: 0.7.h),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 6 Character)");
                        }
                      },
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(5),
                        // isDense: true,
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        // labelText: 'Password',
                        hintText: 'Password',
                        suffixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.red,
                        ),
                        //  errorText: _isloginsuccessful
                        // ? null
                        // : _usernameerrormessage,
                        // errorStyle: TextStyle(height: 0.7.h),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Login with',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'' 't have an Account ? '),
                        GestureDetector(
                          onTap: () {
                            widget.tabController.animateTo(1); //
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SignUp(),
                            //   ),
                            // );
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text('LOGIN'),
                      onPressed: () {
                        signIn();
                        print('signing in');
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    }
  }
}
