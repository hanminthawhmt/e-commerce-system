import 'dart:convert';

class User {
  //Define fields
  final String? id;
  final String? fullName;
  final String? email;
  final String? state;
  final String? city;
  final String? locality;
  final String? password;
  final String? token;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.state,
      required this.city,
      required this.locality,
      required this.password,
      required this.token});

  // Serialization(toJSON) for handling API requests
  // Converts model data before sending (Model object → Map → JSON string).
  // Convert to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token" : token
    };
  }

  // Map to JSON String
  String toJson() {
    return jsonEncode(toMap());
  }

  // Deserialization(fromJSON) for handling API response
  // JSON string → Map → Model object

   // From JSON String to Map
   // factory constructor takes the Json String as parameter
  factory User.fromJson(String source) {
    return User.fromMap(jsonDecode(source) as Map<String, dynamic>);
  } 

  // Convert Map to Model
  // factory constructor takes the Map<String, dynamic> as parameter
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] as String? ?? "",
        fullName: map['fullName'] as String? ?? "",
        email: map['email'] as String? ?? "",
        state: map['state'] as String? ?? "",
        city: map['city'] as String? ?? "",
        locality: map['locality'] as String? ?? "",
        password: map['password'] as String? ?? "",
        token: map['token'] as String? ?? "");
  }
 
  
}
