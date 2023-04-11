import 'package:flutter/material.dart';

class BuildSettingListTile extends StatefulWidget {
  final String leading;

  BuildSettingListTile(this.leading);

  @override
  _BuildSettingListTileState createState() => _BuildSettingListTileState();
}

class _BuildSettingListTileState extends State<BuildSettingListTile> {
  var _toggleSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white.withOpacity(0.2),
          child: ListTile(
            leading: Text(
              widget.leading,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
                activeColor: Colors.green,
                value: _toggleSwitch,
                onChanged: (status) {
                  setState(() {
                    _toggleSwitch = status;
                  });
                }),
          ),
        ),
      ],
    );
  }
}
