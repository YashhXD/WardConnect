class AppUser{
  final String uid;
  final String email;

  AppUser({
    required this.uid,
    required this.email,
  });

  //convert app user into json
  Map<String,dynamic> toJson(){
    return{
      'uid' : uid,
      'email' : email,
    };
  }

  //convert json into app user
  factory AppUser.fromJson(Map<String,dynamic> jsonUser){
    return AppUser(uid: jsonUser['uid'], email: jsonUser['email']);
  }
}