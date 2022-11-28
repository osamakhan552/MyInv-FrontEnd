import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wppl/src/components/appbar.dart';
import 'package:wppl/src/components/tile_button.dart';

class SystemAdminScreen extends StatelessWidget {
  const SystemAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Welcome to the System Admin Home Screen'),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            direction: Axis.horizontal,
            children: [
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/dashboard");
                  },
                  title: 'Dashboard',
                  subtitle: "Show dashboard",
                  icon: Icon(Icons.dashboard, size: 50)),
              TileButton(
                  title: 'Employee Entry',
                  isForm: true,
                  subtitle: "Enter new employee",
                  onPressed: () {
                    Get.toNamed("/admin/employee");
                  },
                  icon: Icon(Icons.work, size: 50)),
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/material");
                  },
                  title: 'Product Entry',
                  isForm: true,
                  icon: Icon(Icons.battery_charging_full, size: 50)),
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/customer");
                  },
                  title: 'Customer Entry',
                  isForm: true,
                  icon: Icon(Icons.shopping_cart, size: 50)),
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/vendor");
                  },
                  title: 'Vendor Entry',
                  isForm: true),
              TileButton(
                  title: 'All Employees',
                  onPressed: () {
                    Get.toNamed("/admin/employee/table");
                  }),
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/material/table");
                  },
                  title: 'All Products'),
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/customer/table");
                  },
                  title: 'All Customers'),
              TileButton(
                  onPressed: () {
                    Get.toNamed("/admin/vendor/table");
                  },
                  title: 'All Vendors'),
              TileButton(
                onPressed: () {
                  Get.toNamed("/admin/purchase");
                },
                title: 'Purchase Order',
                isForm: true,
              ),
              TileButton(
                onPressed: () {
                  Get.toNamed("/admin/orderreceived");
                },
                title: 'Order Receive',
                isForm: true,
              ),
              TileButton(
                onPressed: () {
                  Get.toNamed("/admin/purchase/table");
                },
                title: 'All Purchase',
              ),
              TileButton(
                onPressed: () {
                  Get.toNamed("/admin/orderreceived/table");
                },
                title: 'All Received Orders',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
