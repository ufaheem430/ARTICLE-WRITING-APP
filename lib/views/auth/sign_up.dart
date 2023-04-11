import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:office_work/Multi%20Theming/themes.dart';
import 'package:office_work/views/home/bottom_navigation_bar.dart';
import 'package:office_work/widgets/build_text_field.dart';

import 'package:office_work/widgets/divider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  UserCredential _authResult;
  var _isLoading = false;

  var _name = '';
  var _email = '';
  var _password = '';
  var isLogin = true;

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      try {
        setState(() {
          _isLoading = true;
        });
        print(_email);
        print(_password);

        _authResult = await _auth
            .createUserWithEmailAndPassword(
                email: _email.trim(), password: _password.trim())
            .then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(value.user.uid)
              .set({
            'userID': value.user.uid,
            'userName': _name,
            'email': _email,
            'image': '',
          });
          if (value.user != null) {
            Get.to(BottomNavigation());
          }
        });
      } on FirebaseAuthException catch (err) {
        var errorMessage = 'An error occurred plz try again ';

        if (err.message != null) {
          errorMessage = err.message;
        }
        Get.snackbar('Error Occured', errorMessage,
            colorText: Theme.of(context).errorColor,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 4));

        print('Firebase Auth Exception error :  ${err.code}');
        print(err.message);
      }
      //  on PlatformException catch (err) {}
      catch (error) {
        print(error);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  BuildTextFeild(
                    'Name',
                    fkey: 'SignUpName',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'plz enter your name';
                      }
                      return null;
                    },
                    onsaved: (value) {
                      _name = value;
                    },
                  ),
                  BuildTextFeild(
                    'Email',
                    fkey: 'SignUpEmail',
                    fkeyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty && !value.contains('@')) {
                        return 'plz enter a valid email address';
                      }
                      return null;
                    },
                    onsaved: (value) {
                      _email = value;
                    },
                  ),
                  BuildTextFeild(
                    'Password',
                    fkey: 'SignUpPassword',
                    fkeyboardType: TextInputType.emailAddress,
                    hideText: true,
                    validator: (value) {
                      if (value.isEmpty && value.length < 6) {
                        return 'plz a valid password';
                      }
                      return null;
                    },
                    onsaved: (value) {
                      _password = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Dividerd(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Sign Up',
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
            ),
          ],
        ),
      ),
    );
  }
}
