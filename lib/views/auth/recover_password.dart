import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_work/Multi%20Theming/themes.dart';
import 'package:office_work/widgets/build_text_field.dart';

class RecoverPassword extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _resetPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  BuildTextFeild(
                    'Email',
                    fkey: 'RecoverEmail',
                    fkeyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Required';
                      }
                      if (!value.contains('@')) {
                        return '*Invalid';
                      }
                      return null;
                    },
                    onsaved: (value) {
                      _resetPassword = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text('You will receive the recovery details on your email'),
            SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState.validate()) {
                  return;
                }

                formKey.currentState.save();

                print(_resetPassword);

                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _resetPassword)
                    .then((value) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Reset password Success'),
                          content: Text(
                              'Password has successfully send to your email'),
                        );
                      });
                }).catchError((error) {
                  print(error);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Reset password Failed'),
                          content: Text('Reset Password Failed'),
                        );
                      });
                });
              },
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 50)),
                backgroundColor:
                    MaterialStateProperty.all(CustomTheming.mycurrentColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
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
