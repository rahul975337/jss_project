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
    String citotoID,
  }) async {
    await _gettingSavedUserID();
    return await usersCollection.doc(_myUserID).update({
      'userID': _myUserID,
      'name': name,
      'mobile': mobile.split(' '),
      'mail': mail,
      'image': image,
      'citotoID': citotoID,
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
        citotoID: userDoc.data()['citotoID'],
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

  // to get user's mail address by user's citotoID
  getUserMailbyCitotoId(String citotoID) async {
    QuerySnapshot searchResult =
        await usersCollection.where('citotoID', isEqualTo: citotoID).get();
    if (searchResult != null) {
      return searchResult.docs[0].data()['mail'];
    } else {
      return null;
    }
  }

  // /////////////////////////////////   M I N G L E  ///////////////////////////////////////

  // // to get all chatrooms
  // Future<Stream> getChatRooms({bool professional}) async {
  //   await _gettingSavedUserID();
  //   try {
  //     return await conversationCollection
  //         .where('users', arrayContains: _myUserID)
  //         .snapshots();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  // /////////////////////////////////   C H A T S  ///////////////////////////////////////

  // // to send a message
  // Future sendMessages(
  //     {String documentID, String message, bool professional}) async {
  //   await _gettingSavedUserID();
  //   Timestamp time = Timestamp.fromMillisecondsSinceEpoch(
  //       DateTime.now().millisecondsSinceEpoch);

  //   return await conversationCollection
  //       .doc(documentID)
  //       .collection('conversations')
  //       .add({
  //     'message': message,
  //     'sender': _myUserID,
  //     'time': time.toString(),
  //   });
  // }

  // // to get all chat conversations depending on the mode
  // Future<Stream> getConversations(
  //     {String documentID, bool professional}) async {
  //   await _gettingSavedUserID();

  //   return await conversationCollection
  //       .doc(documentID)
  //       .collection('conversations')
  //       .orderBy('time', descending: true)
  //       .snapshots();
  // }

  // ////////////////////////// P R O F I L E ////////////////////////////////////////

  // Future<Map<String, dynamic>> getProfileData(id) async {
  //   await _gettingSavedUserID();

  //   try {
  //     QuerySnapshot profileQuery =
  //         await usersCollection.where("userID", isEqualTo: id).get();

  //     QuerySnapshot users = await usersCollection.get();

  //     if (profileQuery != null) {
  //       //TODO: replace this whole return with profile modal( Rahul & Shantanu)
  //       return {
  //         "status": "success",
  //         "userName": profileQuery.docs.single.data()['name'][0] +
  //             " " +
  //             profileQuery.docs.single.data()['name'][2],
  //         "authPercent": profileQuery.docs.single.data()['authPercent'],
  //         "image": profileQuery.docs.single.data()['image'],
  //         "citotoID": profileQuery.docs.single.data()['citotoID'],
  //         "mobileNumber": profileQuery.docs.single.data()['mobile'],
  //         "mail": profileQuery.docs.single.data()['mail'],
  //         "auths": profileQuery.docs.single.data()['auths'],
  //         "userID": profileQuery.docs.single.data()['userID'],
  //         "profStatus": profileQuery.docs.single.data()["status"][0],
  //         "socStatus": profileQuery.docs.single.data()["status"][1],
  //       };
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }
}
