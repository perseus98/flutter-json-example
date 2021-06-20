import 'dart:convert';

class UserNew {
  var name;
  var email;

  UserNew(this.name, this.email);

  factory UserNew.fromJsonString(String json) {
    Map data = jsonDecode(json) as Map;
    return UserNew(data['name'], data['email']);
  }

  factory UserNew.fromJson(Map<String, dynamic> json) {
    return UserNew(
      json['name'],
      json['email'],
    );
  }
}
