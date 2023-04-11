import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:office_work/Multi%20Theming/themes.dart';
import 'package:office_work/main.dart';
import 'package:office_work/views/documents/documents.dart';
import 'package:office_work/views/home/reader_mode/reader_mode.dart';
import 'package:office_work/views/settings.dart' as setting;

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> _pages = [
    Documents(),
    ReaderMode(),
    setting.Settings(),
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((userData) {
      myCurrentUser = userData.data();
      print(myCurrentUser);
      setState(() {});
    }).catchError((e) {
      print("Error");
    });
  }

  // Color clr = CustomTheming.currentColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheming.mycurrentColor,
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black.withOpacity(0.7),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF707070),
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.folder,
                ),
                label: 'Documents'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chrome_reader_mode,
                ),
                label: 'Reader Mode'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
