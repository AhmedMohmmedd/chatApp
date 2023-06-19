import 'package:chatapp2/models/textfiled.dart';
import 'package:chatapp2/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:chatapp2/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_h';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../models/button.dart';

class Registerpage extends StatefulWidget {
  static const String screenRout = 'registerScreen';
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  bool showSpinar = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinar,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/images (7).jpeg'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                        },
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      mybutton(
                          color: Colors.blue[900]!,
                          title: 'register',
                          onpressed: () async {
                            setState(() {
                              // showSpinar = true;
                            });
                            if (formKey.currentState!.validate()) {
                              showSpinar = true;
                              try {
                                await registerUser(context);
                                shoeSnacBar(context, 'success');
                                setState(() {
                                 
                                });
                              } on FirebaseAuthException catch (e) {
                                // print(e);
                                if (e.code == 'weak-password') {
                                  shoeSnacBar(context, 'weak-password');
                                } else if (e.code == 'email-already-in-use') {
                                  shoeSnacBar(context, ' email already exists');
                                }
                                showSpinar = false;
                                setState(() {
                                  
                                });
                              }
                              ;
                            } else {}
                          }),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('already have account'),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, signin.screenRout);
                            },
                            child: Text(
                              '  Sign in',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void shoeSnacBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    final newuser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    Navigator.pushNamed(context, signin.screenRout);
  }
}
