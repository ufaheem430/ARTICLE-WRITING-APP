import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:office_work/Multi%20Theming/themes.dart';

import '/views/documents/document_reading.dart';
import '/views/utils/appColor.dart';
import '/widgets/animated_text.dart';

  List<Map<String, dynamic>> myData = [];


class ReaderMode extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheming.mycurrentColor,
        body: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              animatedText(),
              SizedBox(height: 15),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.searchColor,
                    ),
                    border: InputBorder.none,
                    fillColor: Colors.white.withOpacity(0.3),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Articles')
                    .snapshots(),
                builder: (ctx, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final documents = streamSnapshot.data.docs;

                  return Expanded(
                    child: GridView.builder(
                        itemCount: documents.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.65),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(DocumentReading(documents[index]['name'],
                                  documents[index]['text']));
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          documents[index]['date'],
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.dateColor),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: Center(
                                        child: Container(
                                          // color: Colors.amber,
                                          child: Html(
                                            data: documents[index]['text'],
                                            style: {
                                              'p': Style(
                                                  alignment: Alignment.center,
                                                  fontSize: FontSize.medium,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.center,
                                                  textDecorationStyle:
                                                      TextDecorationStyle
                                                          .double),
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          documents[index]['name'],
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.dateColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
