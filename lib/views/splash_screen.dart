import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Center(
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText('Write',
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  speed: Duration(milliseconds: 500)),
            ],
          ),
        ),
      ),
    );
  }
}
