class Users {
  String citotoID;
  String username;
  String dp;
  String mobile;
  String mail;
  int auth;

  Users({
    this.citotoID,
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
