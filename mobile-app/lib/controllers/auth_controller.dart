import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/user.dart';
import 'package:multi_store_app/services/handle_http_response.dart';
import 'package:multi_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password,
          token: '');
      final response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(), headers: {'Content-Type': 'application/json'});
      handleResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            showSnackBar(context, 'Account has been successfully created');
          });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signInUsers(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: {'Content-Type': 'application/json'});
      handleResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainScreen()),(Route<dynamic>route)=> false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      print('Error: $e');
    }
  }
}
