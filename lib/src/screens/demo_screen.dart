import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wppl/src/components/appbar.dart';
import 'package:wppl/src/routes.dart';

///
/// Screen for testing routes
///
///

class DemoScreen extends StatelessWidget {
  final String? title;
  const DemoScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        key: key,
        title: title ?? 'Demo screen',
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(routes[index].name);
                  },
                  child: SelectableText(routes[index].name)),
            ),
          ),
        ),
      ),
    );
  }
}
