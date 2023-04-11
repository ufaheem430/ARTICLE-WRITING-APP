import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:office_work/Multi%20Theming/themes.dart';
import 'package:office_work/widgets/animated_text.dart';
import 'package:office_work/widgets/buildSettingListTile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _toggleSwitch = false;
  final _googleSignIn = GoogleSignIn();

  // Color currentColor = Colors.limeAccent;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) =>
      setState(() => CustomTheming.mycurrentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheming.mycurrentColor,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.2),
          centerTitle: true,
          title: Text('Settings'),
          actions: [
            IconButton(
              onPressed: () async {
                Get.defaultDialog(
                    radius: 0,
                    title: 'LOGOUT',
                    content: Text('Are you sure to logout?'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              await FirebaseAuth.instance.signOut();
                              await _googleSignIn.disconnect();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      ),
                    ]);
              },
              icon: Icon(Icons.exit_to_app),
              color: Colors.red,
            ),
            // DropdownButton(
            //   icon: Icon(
            //     Icons.more_vert,
            //     color: Colors.white,
            //   ),
            //   items: [
            //     DropdownMenuItem(
            //       child: Row(
            //         children: [
            //           Icon(
            //             Icons.exit_to_app,
            //             color: Colors.red,
            //           ),
            //           SizedBox(width: 8),
            //           Text('Log Out')
            //         ],
            //       ),
            //       value: 'logout',
            //     ),
            //   ],
            //   onChanged: (itemIdentifier) async {
            //     if (itemIdentifier == 'logout') {
            //       await FirebaseAuth.instance.signOut();
            //       await g.disconnect();
            //     }
            //   },
            // ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text(
                'WRITING',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white.withOpacity(0.4)),
              ),
              BuildSettingListTile('Keyboard Sound'),
              BuildSettingListTile('Auto Save'),
              BuildSettingListTile('Suggest Changes'),
              BuildSettingListTile('Show Word Count'),
              SizedBox(height: 10),
              Text(
                'Other',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white.withOpacity(0.4)),
              ),
              // h.MyCustomTheme(),

              RaisedButton(
                  elevation: 3.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select a color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: CustomTheming.mycurrentColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Done',
                                  style: Theme.of(context).textTheme.button,
                                ))
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'change theme',
                  ),
                  color: Colors.white.withOpacity(0.2),
                  textColor: Colors.white
                  // useWhiteForeground(CustomTheming.mycurrentColor)
                  //     ? const Color(0xffffffff)
                  //     : const Color(0xff000000),
                  ),

              // TextButton(
              //     onPressed: () {

              //     },
              //     child: Text('click here')),
              _buildOtherListTile('Page Setup'),
              _buildOtherListTile('Share & Export'),
              _buildOtherListTile('Help and Feedback'),
              _buildOtherListTile('Privacy Policy'),
              SizedBox(height: 40),
              animatedText()
            ],
          ),
        ),
      ),
    );
  }
}

// Future maketheme(BuildContext context) {
//   return showDialog(context: context, builder: builder);
// }

Widget _buildOtherListTile(String leading) {
  return Card(
    color: Colors.white.withOpacity(0.2),
    child: ListTile(
        leading: Text(
          leading,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(Icons.forward)),
  );
}
