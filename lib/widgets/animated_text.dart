import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:office_work/views/utils/const.dart';
// import 'package:sign_button/sign_button.dart';

Widget animatedText() {
  return Center(
    child: AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(AppConst.APP_NAME,
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white))
      ],
    ),
  );
}
