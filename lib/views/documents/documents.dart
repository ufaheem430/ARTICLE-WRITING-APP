import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:office_work/Multi%20Theming/themes.dart';
import '/views/documents/document_reading.dart';
import '/views/documents/new_document.dart';
import '/views/utils/appColor.dart';
import '/widgets/animated_text.dart';

class Documents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheming.mycurrentColor,
        body: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
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
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: AppColor.searchColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Articles')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .snapshots(),
                  builder: (ctx, streamSnapshot) {
                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // final documents = streamSnapshot.data!.docs;
                    final documents = streamSnapshot.data.docs;

                    return Expanded(
                      child: GridView.builder(
                          itemCount: documents.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.65),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => index == 0
                                  ? Get.to(NewDocument())
                                  : Get.to(DocumentReading(
                                      documents[index - 1]['name'],
                                      documents[index - 1]['text'])),
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 3, right: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: index == 0
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.white,
                                  ),
                                  child: index == 0
                                      ? Icon(
                                          Icons.add,
                                          size: 80,
                                          color: Colors.white.withOpacity(0.4),
                                        )
                                      : Column(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  documents[index - 1]['date'],
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColor.dateColor),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 5,
                                              fit: FlexFit.tight,
                                              child: Center(
                                                child: Container(
                                                  // color: Colors.amber,
                                                  child: Html(
                                                    data: documents[index - 1]
                                                        ['text'],
                                                    style: {
                                                      'p': Style(
                                                          alignment:
                                                              Alignment.center,
                                                          fontSize:
                                                              FontSize.medium,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          textAlign:
                                                              TextAlign.center,
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
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  documents[index - 1]
                                                          ['name'] ??
                                                      "",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColor.dateColor),
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
      ),
    );
  }
}
