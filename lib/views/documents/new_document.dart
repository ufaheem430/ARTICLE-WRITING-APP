import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:office_work/main.dart';

import 'package:office_work/widgets/animated_text.dart';

class NewDocument extends StatefulWidget {
  @override
  _NewDocumentState createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {
  HtmlEditorController _controller = HtmlEditorController();

  bool _isLoading = false;
  int numLines = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(6),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _isLoading
                          ? CircularProgressIndicator()
                          : TextButton(
                              onPressed: () async {
                                String result = await _controller.getText();
                                // if (result.contains("<img src=\"data:image")) {
                                //   result =
                                //       "<text removed due to base-64 image data, displaying the text could cause the app to crash>";
                                // }
                                setState(() {
                                  _isLoading = true;
                                });
                                await FirebaseFirestore.instance
                                    .collection('Articles')
                                    .add({
                                  'text': result,
                                  'uid': myCurrentUser['userID'],
                                  'name': myCurrentUser['userName'] ?? "",
                                  'date': DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()),
                                }).whenComplete(() {
                                  _controller.clear();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                            ),
                      animatedText(),
                      TextButton(
                        onPressed: () {
                          print('Number of lines = $numLines');
                        },
                        child: Text(
                          'Share',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  HtmlEditor(
                    controller: _controller,
                    hint: "Your text here...",
                    //value: "text content initial, if any",
                    height: 400,
                    callbacks: Callbacks(
                      onChange: (e) {
                        setState(() {
                          numLines = '</p>'.allMatches(e).length;
                        });
                      },
                    ),

                    // callbacks: Callbacks(
                    //   onChange: (String changed) {
                    //     print("content changed to $changed");
                    //   },
                    //   onEnter: () {
                    //     print("enter/return pressed");
                    //   },
                    //   onFocus: () {
                    //     print("editor focused");
                    //   },
                    //   onBlur: () {
                    //     print("editor unfocused");
                    //   },
                    //   onBlurCodeview: () {
                    //     print("codeview either focused or unfocused");
                    //   },
                    //   onKeyDown: (keyCode) {
                    //     print("$keyCode key downed");
                    //   },
                    //   onKeyUp: (keyCode) {
                    //     print("$keyCode key released");
                    //   },
                    //   onPaste: () {
                    //     print("pasted into editor");
                    //   },
                    // ),
                    plugins: [
                      SummernoteEmoji(),
                      AdditionalTextTags(),
                      SummernoteClasses(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
