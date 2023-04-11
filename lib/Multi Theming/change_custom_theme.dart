import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:office_work/Multi%20Theming/themes.dart';

class ChangeCustomTheme extends StatefulWidget {
  @override
  _ChangeCustomThemeState createState() => _ChangeCustomThemeState();
}

class _ChangeCustomThemeState extends State<ChangeCustomTheme> {
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) =>
      setState(() => CustomTheming.mycurrentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
      child: const Text('Change me'),
      color: CustomTheming.mycurrentColor,
      textColor: useWhiteForeground(CustomTheming.mycurrentColor)
          ? const Color(0xffffffff)
          : const Color(0xff000000),
    );
  }
}
