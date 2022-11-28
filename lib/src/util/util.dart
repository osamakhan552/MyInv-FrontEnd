import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_connect/http/src/http/html/file_decoder_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wppl/src/controllers/login_controller.dart';
import '../components/constant.dart';
import 'api_methods_mixin.dart';
import '../const.dart';

Future<bool> initialzeApp() async {
  await initializeControllers();
  // RolesModel.roles = await getAll<RolesModel>(creator: () => RolesModel());
  return true;
}

Future initializeControllers() async {
  Get.put(LoginController());
}

class CountWrapper {
  int count;

  CountWrapper(this.count);
}

Future<List<T>> getAll<T extends JsonifyClass>(
    {required T Function() creator,
    String? search,
    int? limit,
    int? offset,
    CountWrapper? totalCount}) async {
  limit ??= 0;
  offset ??= 0;
  search ??= "";

  List<T> list = List.empty(growable: true);
  final T tmp = creator();
  print("GET");
  ;
  print(tmp.baseOptions.headers);
  final resp =
      await dio.Dio(tmp.baseOptions..headers = {"Authorization": authToken})
          .get(tmp.endpoint, queryParameters: {
    "search": search,
    "limit": limit,
    "offset": offset
  });
  final jsonList = resp.data['results'];
  int count = jsonList.length;

  totalCount?.count = resp.data['count'];
  print(tmp.endpoint);
  print(resp.statusCode);
  print(jsonEncode(jsonList));

  if (resp.statusCode == 200) {
    print("IN MY STATUS CODE");
    for (int i = 0; i < count; i++) {
      print(i);
      final model = creator();
      model.fromJson(jsonList[i]);

      list.add(model);
    }
  }
  print(list);
  return list;
}

Future<T> getOne<T extends JsonifyClass>(
    {required T Function() creator, String? id}) async {
  final T tmp = creator();
  try {
    final response =
        await dio.Dio(tmp.baseOptions..headers = {"Authorization": authToken})
            .get(tmp.endpoint + "/" + id!);
    print(response.data);
    if (response.statusCode == 200) {
      showSuccessMsg(message: "Added successfully");
      final model = creator();
      model.fromJson(response.data);
      return model;
    }
    return tmp;
  } on dio.DioError catch (e) {
    showErrorMsg(error: e.response?.data.toString());
    return tmp;
  }
}

Future<List<T>> get<T extends JsonifyClass>(
    T Function() creator, String s) async {
  List<T> list = List.empty(growable: true);
  final T tmp = creator();
  final resp =
      await dio.Dio(tmp.baseOptions..headers = {"Authorization": authToken})
          .get(tmp.endpoint + "/" + s);
  final jsonList = resp.data['results'];
  int count = jsonList.length;
  print(count);
  // print(jsonEncode(jsonList));
  if (resp.statusCode == 200) {
    for (int i = 0; i < count; i++) {
      final model = creator();
      model.fromJson(jsonList[i]);
      list.add(model);
    }
  }
  return list;
}

void showSuccessMsg({String? message, Color? color}) {
  message = message ?? "Successfull";

  Get.snackbar(
    message,
    "",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color ?? Colors.green,
    borderRadius: 20,
    margin: EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

void showErrorMsg({String? message, String? error}) {
  message = message ?? "Oops, something went worng";

  Get.snackbar(
    message,
    error ?? "",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kPrimaryColor,
    borderRadius: 20,
    margin: EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

void showWarningMsg({String? message, String? warning}) {
  message = message ?? "Oops, something went worng";
  warning = warning ?? "";

  Get.snackbar(
    message,
    warning,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.yellow,
    borderRadius: 20,
    margin: EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

void downloadFile(String uRL) async {
  try {
    final response =
        await dio.Dio(dio.BaseOptions(headers: {"Authorization": authToken}))
            .get(baseApiUrl + "export/token");

    final token = response.data["token"];

    launch(uRL + "/$token");
  } catch (e) {
    showErrorMsg(error: e.toString());
  }

  // print(resp.data);

//   final blob = html.Blob(fileToBytes(resp.data));
//   final url = html.Url.createObjectUrlFromBlob(blob);
//   final anchor = html.document.createElement('a') as html.AnchorElement
//     ..href = url
//     ..style.display = 'none'
//     ..download = 'export.xls';

//   html.document.body?.children.add(anchor);

// // download
//   anchor.click();

// // cleanup
//   html.document.body?.children.remove(anchor);
//   html.Url.revokeObjectUrl(url);
}

// void downloadResponseFile(var resp) {
//   print(resp.data);

//   final blob = html.Blob(fileToBytes(resp.data));
//   final url = html.Url.createObjectUrlFromBlob(blob);
//   final anchor = html.document.createElement('a') as html.AnchorElement
//     ..href = url
//     ..style.display = 'none'
//     ..download = 'export.xls';

//   html.document.body?.children.add(anchor);

// // download
//   anchor.click();

// // cleanup
//   html.document.body?.children.remove(anchor);
//   html.Url.revokeObjectUrl(url);
// }

void importFile(file, String url) async {
  try {
    //print("in import");
    //print(String.fromCharCodes(file.path));
    String fileName = file.name;
    String success = "imported successfully";
    //print('$fileName');
    List<int> list = file.bytes;
    var formData = dio.FormData.fromMap({
      await "file": dio.MultipartFile.fromBytes(list, filename: fileName),
    });

    var response =
        await dio.Dio(dio.BaseOptions(headers: {"Authorization": authToken}))
            .post(baseApiUrl + url, data: formData);
    // downloadResponseFile(response);
    // print("$response.data");
    showSuccessMsg(message: success);
  } catch (e) {
    showErrorMsg(error: e.toString());
  }
}

Future<void> sendEmail(String auditId) async {
  try {
    String url = "audits/osirMail/";
    String success = "mail sent successfully";
    var response =
        await dio.Dio(dio.BaseOptions(headers: {"Authorization": authToken}))
            .post(baseApiUrl + url + auditId, data: auditId);
    print(response);
    showSuccessMsg(message: success);
  } catch (e) {
    showErrorMsg(error: e.toString());
  }
}

Future<void> forgotPassword(String username) async {
  try {
    String url = "employees/changePasswordMail/";
    var response =
        await dio.Dio(dio.BaseOptions(headers: {"Authorization": authToken}))
            .get(baseApiUrl + url + username);
    print(response);
  } catch (e) {
    showErrorMsg(error: e.toString());
  }
}
