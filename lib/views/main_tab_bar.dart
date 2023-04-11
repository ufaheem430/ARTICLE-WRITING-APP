import 'package:flutter/material.dart';
import 'package:office_work/Multi%20Theming/themes.dart';
import 'package:office_work/views/auth/recover_password.dart';
import 'package:office_work/views/auth/sign_in.dart';
import 'package:office_work/views/auth/sign_up.dart';

import 'package:office_work/widgets/animated_text.dart';

class MainTabBar extends StatefulWidget {
  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomTheming.mycurrentColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrollable) {
              return <Widget>[
                SliverAppBar(
                  toolbarHeight: 250,
                  backgroundColor: CustomTheming.mycurrentColor,
                  floating: true,
                  pinned: true,
                  title: Center(
                    child: animatedText(),
                  ),
                  bottom: TabBar(
                      unselectedLabelColor: Colors.white.withOpacity(0.65),
                      labelColor: Colors.white,
                      labelStyle: TextStyle(),
                      labelPadding: const EdgeInsets.only(bottom: 30),
                      tabs: [
                        Text(
                          'Sign In',
                          style: TextStyle(),
                        ),
                        Text(
                          'Reset',
                          style: TextStyle(),
                        ),
                        Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
              ),
              child: TabBarView(
                children: [
                  SignIn(),
                  RecoverPassword(),
                  SignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
