import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jss_project/models/user.dart';

import '../helperFunctions/sharedFunctions.dart';

class DatabaseService {
  Users _myData;

  // for getting current location and saved userID
  String _myUserID;
  _gettingSavedUserID() async {
    await SharedFunctions.getUserIDSharedPreference()
        .then((value) => _myUserID = value);
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  // final CollectionReference conversationCollection =
  //     FirebaseFirestore.instance.collection('Chats');

  Future updateUsersInfo({
    List<String> name,
    String mobile,
    String mail,
    String image,
    String dob,
    String jssID,
  }) async {
    await _gettingSavedUserID();
    return await usersCollection.doc(_myUserID).update({
      'userID': _myUserID,
      'name': name,
      'mobile': mobile.split(' '),
      'mail': mail,
      'image': image,
      'jssID': jssID,
    });
  }

  // to get userdetails using userID
  Future<Users> getUserDetailsByUserId(String userID) async {
    await _gettingSavedUserID();
    DocumentSnapshot userDoc =
        await usersCollection.doc(userID).get().catchError((e) {
      print('\nData Parsing Error- $e\n');
    });
    if (userDoc != null) {
      List nameList = userDoc.data()['name'];
      _myData = Users(
        jssID: userDoc.data()['jssID'],
        username: nameList[0] + ' ' + nameList[2],
        dp: userDoc.data()['image'],
        mobile: userDoc.data()['mobile'].join(' '),
        mail: userDoc.data()['mail'],
      );
      return _myData;
    } else {
      return null;
    }
  }

  // to get user's mail address by user's jssID
  getUserMailbyJSSId(String jssID) async {
    QuerySnapshot searchResult =
        await usersCollection.where('jssID', isEqualTo: jssID).get();
    if (searchResult != null) {
      return searchResult.docs[0].data()['mail'];
    } else {
      return null;
    }
  }
}
