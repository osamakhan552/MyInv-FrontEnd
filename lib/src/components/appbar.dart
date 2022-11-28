import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wppl/src/components/constant.dart';
import 'package:wppl/src/controllers/login_controller.dart';
import 'package:wppl/src/models/employee_model.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  // AuditScheduleModel item
  const MyAppBar(
      {Key? key, required this.title, this.bottom, this.toolbarHeight})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  void logOut() {
    Get.find<LoginController>().logOut();
  }

  String getName() {
    switch (Get.find<LoginController>().role) {
      case Roles.admin:
        return Get.find<LoginController>().adminName;

      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SelectableText(title),
      toolbarHeight: toolbarHeight,
      centerTitle: true,
      bottom: bottom,
      actions: [
        Center(child: SelectableText('Hi, ${getName()}!')),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: logOut,
          child: Text('Log Out'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
        ),
      ],
      backgroundColor: kPrimaryColor,
    );
  }
}
