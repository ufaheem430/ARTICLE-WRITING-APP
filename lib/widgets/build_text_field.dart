import 'package:flutter/material.dart';

class BuildTextFeild extends StatelessWidget {
  String hintText;
  String fkey;
  bool hideText;
  TextInputType fkeyboardType;
  Function validator;
  Function onsaved;

  BuildTextFeild(this.hintText,
      {this.validator,
      this.onsaved,
      this.fkey,
      this.hideText = false,
      this.fkeyboardType});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        TextFormField(
          obscureText: hideText,
          key: ValueKey(fkey),
          keyboardType: fkeyboardType,
          validator: validator,
          onSaved: onsaved,
          strutStyle: StrutStyle(height: 1),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
    // return Center(
    //   child: Card(
    //     elevation: 0,
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       width: MediaQuery.of(context).size.width * 1,
    //       height: 50,
    //       child:
    //     ),
    //   ),
    // );
  }
}
