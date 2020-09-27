import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions {
  //
  ////////////////////////////////   K E Y S   ////////////////////////////////////////

  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserJSSIdKey = 'USERJSSIDKEY';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserImageKey = 'USERIMAGEKEY';
  static String sharedPreferenceUserIDKey = 'USERIDKEY';


  ////////////////////////////    S E T | F U N C T I O N S   ////////////////////////////////

  // User's status about logged in or not
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  // User's JSSId
  static Future<bool> saveUserJSSIdSharedPreference(
      String userJSSID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserJSSIdKey, userJSSID);
  }

  // My Name
  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  // My Email
  static Future<bool> saveUserImageSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserImageKey, userEmail);
  }

  // My UserId
  static Future<bool> saveUserIDSharedPreference(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserIDKey, userID);
  }

  ////////////////////////////    G E T | F U N C T I O N S   ////////////////////////////////

  // User's status about logged in or not
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  // User's JSSId
  static Future<String> getUserJSSIdSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserJSSIdKey);
  }

  // User's Name
  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  // User's Email
  static Future<String> getUserImageSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserImageKey);
  }

  // User's UserId
  static Future<String> getUserIDSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserIDKey);
  }
}
