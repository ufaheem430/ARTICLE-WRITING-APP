import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserModel {
  String userId;
  String name;
  String email;

  UserModel({this.userId, this.name, this.email});

  factory UserModel.fromJson(Map<String, dynamic> userData) {
    return UserModel(
        email: userData['email'],
        name: userData['name'],
        userId: userData['uid']);
  }

  List<Map<String, dynamic>> mydata = [];

  getData() async {
    final docs =
        await FirebaseFirestore.instance.collection('Articles').doc().get();
    var data = docs.data();
    mydata.add(data);
  }
}
