
class UserModel {
  String? userId;
  String? username;
  String? email;
  String? phone;
  String? profilePic;
  List<String>? favorite;

  UserModel({this.userId, this.username, this.email, this.phone, this.profilePic, this.favorite});

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json["userId"] is String) {
      userId = json["userId"];
    }
    if(json["username"] is String) {
      username = json["username"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phone"] is String) {
      phone = json["phone"];
    }
    if(json["profilePic"] is String) {
      profilePic = json["profilePic"];
    }
    if(json["favorite"] is List) {
      favorite = json["favorite"] == null ? null : List<String>.from(json["favorite"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["username"] = username;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["profilePic"] = profilePic;
    if(favorite != null) {
      _data["favorite"] = favorite;
    }
    return _data;
  }
}