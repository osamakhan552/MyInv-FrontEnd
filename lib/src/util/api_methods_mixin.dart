import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/constant.dart';
import 'util.dart';

import '../const.dart';

///
/// Base url of api
///

///
/// Implementing class must override `toJson`
/// function for it is needed in `ApiMethods` class
///
abstract class JsonifyClass {
  String endpoint = "";
  BaseOptions baseOptions = BaseOptions();

  Map<String, dynamic> toJson() {
    return {};
  }

  void fromJson(Map<String, dynamic> json) {}
}

mixin ApiMethods implements JsonifyClass {
  // @override
  // BaseOptions baseOptions =
  @override
  BaseOptions baseOptions = BaseOptions(
      baseUrl: apiUrl,
      responseType: ResponseType.json,
      headers: {"Authorization": authToken});

  Future<void> put(String? id) async {
    try {
      // print(endpoint + "/" + (id ?? ""));
      final response =
          await Dio(baseOptions..headers = {"Authorization": authToken})
              .put(endpoint + "/" + (id ?? ""), data: jsonEncode(toJson()));
      if (response.statusCode == 200)
        showSuccessMsg(message: "Updated successfully");
    } on DioError catch (e) {
      showErrorMsg(error: e.response?.data.toString());
    }
  }

  Future<void> post() async {
    // print(toJson());
    try {
      print("my endpoint:  == " + endpoint);
      print("Token" + authToken);
      final response =
          await Dio(baseOptions..headers = {"Authorization": authToken}).post(
        endpoint,
        data: toJson(),
      );
      if (response.statusCode == 201)
        showSuccessMsg(message: "Added successfully");
    } on DioError catch (e) {
      showErrorMsg(error: e.response?.data.toString());
    }
  }

  Future<void> delete(String? id) async {
    try {
      final response =
          await Dio(baseOptions..headers = {"Authorization": authToken})
              .delete(endpoint + "/" + (id ?? ""), data: toJson());

      if (response.statusCode == 204)
        showSuccessMsg(message: "Deleted successfully", color: kPrimaryColor);
    } on DioError catch (e) {
      showErrorMsg(error: e.response?.data.toString());
    }
  }
}
