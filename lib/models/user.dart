class Users {
  String jssID;
  String username;
  String dp;
  String mobile;
  String mail;
  int auth;

  Users({
    this.jssID,
    this.username,
    this.dp,
    this.mobile,
    this.mail,
    this.auth,
  });
}

class CurrentUser {
  final String uID;

  CurrentUser({this.uID});
}

class PeopleTag {
  final String uID;
  final String name;
  final String imageUrl;

  PeopleTag({this.uID, this.name, this.imageUrl});
}
