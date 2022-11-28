import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wppl/src/const.dart';
import 'package:wppl/src/util/util.dart';
import 'dart:convert';
import 'package:http/http.dart';

enum Roles { admin, logout }

class LoginController extends GetxController {
  final bool _isLoggedIn = false;
  final String _authToken = "";
  final _role = Roles.logout.obs;
  final _obscurePassword = true.obs;
  String adminName = "";

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isLoggedIn => _isLoggedIn;
  // String get authToken => _authToken;
  Roles? get role => _role.value;

  bool get obscurePassword => _obscurePassword.value;

  void changePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void logIn() async {
    final data = {
      "username": usernameController.text,
      "password": passwordController.text
    };
    try {
      print(data["username"]);
      final response =
          await Dio().post("https://dev-myinv.herokuapp.com/token", data: data);
      print(response);
      print(response.data["token"]);
      // print(response.data["name"]);
      authToken = "Token " + response.data["token"];
      print(authToken);
      final String role = response.data["role"];
      adminName = response.data["name"];

      print(role);

      if (role.toLowerCase().contains("admin")) {
        _role.value = Roles.admin;
      } else {
        _role.value = Roles.logout;
      }
    } catch (e) {
      print("error occur");
      showErrorMsg(message: "Sorry Wrong Credentials");
    }
    update();
  }

  void logOut() {
    _role.value = Roles.logout;
    update();
    Get.offNamed("/");
    update();
  }
}
