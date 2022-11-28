import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wppl/src/components/tables/employee_table.dart';
import 'package:wppl/src/components/tables/material_table.dart';
import 'package:wppl/src/components/tables/order_table.dart';
import 'package:wppl/src/components/tables/order_received_table.dart';
import 'package:wppl/src/components/tables/vendor_table.dart';
import 'package:wppl/src/screens/dashboard.dart';

import 'package:wppl/src/controllers/login_controller.dart';

import 'package:wppl/src/screens/loginScreen.dart';

import 'package:wppl/src/screens/admin_screen.dart';
import 'package:wppl/src/screens/error404.dart';

import 'package:wppl/src/forms/admin/employee.dart';
import 'package:wppl/src/forms/admin/material.dart';
import 'package:wppl/src/forms/admin/order.dart';
import 'package:wppl/src/forms/admin/order_received_form.dart';

import 'package:wppl/src/forms/systemadmin.dart';
import 'package:wppl/src/forms/admin/vendor.dart';

import 'components/tables/customer_table.dart';
import 'forms/admin/customer.dart';

final pageNotFound = GetPage(name: "/404", page: () => const PageNotFound());

const Transition? transition = Transition.native;

Widget goToScreen(Roles role, Widget screen) {
  final cntrl = Get.find<LoginController>();
  // return screen;
  if (role == cntrl.role) return screen;
  // Get.offNamed("/");
  return LoginScreen();
}

final routes = [
  GetPage(
    name: "/",
    page: () => LoginScreen(),
    transition: transition,
  ),
  GetPage(
    name: "/admin",
    page: () => goToScreen(Roles.admin, SystemAdminScreen()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/dashboard",
    page: () => goToScreen(Roles.admin, AdminDashboard()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/employee",
    page: () => goToScreen(Roles.admin, EmployeeForm()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/employee/table",
    page: () => goToScreen(Roles.admin, EmployeeTableWrapper()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/material",
    page: () => goToScreen(Roles.admin, MaterialEntry()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/material/table",
    page: () => goToScreen(Roles.admin, MaterialTableWrapper()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/customer",
    page: () => goToScreen(Roles.admin, CustomerForm()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/customer/table",
    page: () => goToScreen(Roles.admin, CustomerTableWrapper()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/vendor",
    page: () => goToScreen(Roles.admin, VendorForm()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/vendor/table",
    page: () => goToScreen(Roles.admin, VendorTableWrapper()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/purchase",
    page: () => goToScreen(Roles.admin, OrderForm()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/purchase/table",
    page: () => goToScreen(Roles.admin, OrderTableWrapper()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/orderreceived",
    page: () => goToScreen(Roles.admin, OrderReceivedForm()),
    transition: transition,
  ),
  GetPage(
    name: "/admin/orderreceived/table",
    page: () => goToScreen(Roles.admin, OrderReceivedTableWrapper()),
    transition: transition,
  ),
];

final d8froms = [];
