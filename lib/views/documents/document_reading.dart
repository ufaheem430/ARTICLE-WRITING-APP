import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:office_work/Multi%20Theming/themes.dart';
import 'package:office_work/views/utils/const.dart';

import 'package:office_work/widgets/animated_text.dart';

class DocumentReading extends StatelessWidget {
  String _authorName;
  String _description;

  DocumentReading(this._authorName, this._description);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheming.mycurrentColor,
        body: Container(
          margin: const EdgeInsets.all(6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Color(0xFF707070),
                    ),
                  ),
                  Center(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          AppConst.APP_NAME,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2F2E2B).withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Share',
                      style: TextStyle(color: Color(0xFF707070), fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                // margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Song for the Old Ones',
                    //   style: TextStyle(fontSize: 22),
                    // ),
                    Center(
                      child: Text(
                        'By $_authorName',
                        style:
                            TextStyle(color: Color(0xFF707070), fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Text(_description),
                    Html(
                      data: _description,
                      style: {
                        'p': Style(
                            alignment: Alignment.center,
                            fontSize: FontSize.medium,
                            textAlign: TextAlign.center,
                            textDecorationStyle: TextDecorationStyle.double),
                      },
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
