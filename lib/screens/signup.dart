import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/models/user_model.dart';

import 'myhomepage.dart';

class SignUp extends StatefulWidget {
  final TabController tabController;
  // const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
  SignUp({required this.tabController});
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  bool _ischecked = false;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Create an\nAccount',
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
                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        controller: nameController,
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
                          //labelText: 'Name',
                          hintText: 'John doe',
                          suffixIcon: Icon(
                            Icons.account_circle,
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
                        controller: emailController,
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
                          labelText: 'Email',
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
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
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
                          labelText: 'Phone',
                          //  hintText: 'johndoe@gmail.com',
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.red,
                          ),
                          //  errorText: _isloginsuccessful
                          // ? null
                          // : _usernameerrormessage,
                          // errorStyle: TextStyle(height: 0.7.h),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
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
                          labelText: 'Password',
                          hintText: '',
                          suffixIcon: Icon(
                            Icons.lock,
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
                      Center(
                        child: CheckboxListTile(
                          side: BorderSide(color: Colors.red, width: 2),
                          title: Text("I agree with term and condition"),
                          value: _ischecked,
                          onChanged: (newValue) {
                            setState(() {
                              _ischecked = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an Account? '),
                              GestureDetector(
                                onTap: (() {
                                  widget.tabController.animateTo(0);
                                }),
                                child: Text(
                                  'Sign In!',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: Text('REGISTER'),
                        onPressed: () {
                          signup();
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
      ),
    );
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        switch (e.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => MyHomePage()),
    //     (route) => false);
  }
}
