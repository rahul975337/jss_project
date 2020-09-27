import 'package:firebase_auth/firebase_auth.dart';
import 'package:jss_project/models/user.dart';
import 'package:jss_project/services/database.dart';

import '../helperFunctions/sharedFunctions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _database = DatabaseService();

  // Create User Object based on Firebase User
  CurrentUser _userFromFirebaseUser(User user) {
    return (user != null) ? CurrentUser(uID: user.uid) : null;
  }

  // auth change user stream
  Stream<CurrentUser> get user {
    return _auth
        .authStateChanges()
        // .map((FirebaseUser user) => _userFromFirebase(user));
        .map(_userFromFirebaseUser);
  }

  // Login with jss ID and Password
  Future signInJSSID(String jssID, String password) async {
    try {
      String email = await _database.getUserMailbyJSSId(jssID);
      if (email != null) {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User user = result.user;
        Users userdat = await _database.getUserDetailsByUserId(user.uid);
        String userName = userdat.username;
        String userImage = userdat.dp;

        // setting preferences as soon as someone logs in
        SharedFunctions.saveUserLoggedInSharedPreference(true);
        SharedFunctions.saveUserIDSharedPreference(user.uid);
        SharedFunctions.saveUserImageSharedPreference(userImage);
        SharedFunctions.saveUserJSSIdSharedPreference(jssID);
        SharedFunctions.saveUserNameSharedPreference(userName);
        return _userFromFirebaseUser(user);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Reset Password Link
  Future resetPassword(String email, String jssID) async {
    try {
      final String result = await _database.getUserMailbyJSSId(jssID);
      if (result == email) {
        return await _auth.sendPasswordResetEmail(email: email).catchError((e) {
          print(e);
        });
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    var meh;
    try {
      SharedFunctions.saveUserLoggedInSharedPreference(false);
      SharedFunctions.saveUserIDSharedPreference(meh);
      SharedFunctions.saveUserImageSharedPreference(meh);
      SharedFunctions.saveUserJSSIdSharedPreference(meh);
      SharedFunctions.saveUserNameSharedPreference(meh);

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
