import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:office_work/Multi%20Theming/themes.dart';

import 'package:office_work/widgets/divider.dart';
import 'package:office_work/widgets/build_text_field.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  UserCredential _authResult;
  var _isLoading = false;
  var _isGoogleButtonLoading = false;

  var _email = '';
  var _password = '';
  var isLogin = true;
  final _googleSignIn = GoogleSignIn();

  Future<void> _googleLogIn() async {
    try {
      setState(() {
        _isGoogleButtonLoading = true;
      });
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        UserCredential result = await _auth.signInWithCredential(credential);
        User user = result.user;
        if (result != null) {
          Map<String, dynamic> map = {
            'uid': user.uid,
            'name': user.displayName,
            'email': user.email,
          };
          await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .set(map);
          print(user.uid);
          print(user.displayName);
          print(user.email);
        }
      }
    } catch (e) {
      print('error $e');

      setState(() {
        _isGoogleButtonLoading = false;
      });
    }
    setState(() {
      _isGoogleButtonLoading = false;
    });
  }

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      try {
        setState(() {
          _isLoading = true;
        });
        _authResult = await _auth.signInWithEmailAndPassword(
            email: _email.trim(), password: _password.trim());
      } on FirebaseAuthException catch (err) {
        var errorMessage = 'An error occurred plz try again ';

        if (err.message != null) {
          errorMessage = err.message;
        }
        Get.snackbar('Error Occured', errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Theme.of(context).errorColor);
        print('Firebase Auth Exception error :  ${err.code}');
        print(err.message);
      } catch (error) {
        print(error);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BuildTextFeild(
                'Email',
                fkey: 'SignInEmail',
                fkeyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty && value.contains('@')) {
                    return 'plz enter a valid email address';
                  }
                  return null;
                },
                onsaved: (value) {
                  _email = value;
                },
              ),
              BuildTextFeild(
                'password',
                fkey: 'SignInPassword',
                fkeyboardType: TextInputType.emailAddress,
                hideText: true,
                validator: (value) {
                  if (value.isEmpty && value.length < 6) {
                    return 'plz enter a valid password';
                  }
                  return null;
                },
                onsaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 1, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            CustomTheming.mycurrentColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              Dividerd(),
              SizedBox(height: 20),
              _isGoogleButtonLoading
                  ? CircularProgressIndicator()
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      child: SignInButton(
                        Buttons.Google,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        onPressed: _googleLogIn,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
