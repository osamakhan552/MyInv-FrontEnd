import 'package:flutter/material.dart';

///
/// 404 page
///

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SelectableText(
              "Page Not Found",
              style: TextStyle(fontSize: 50),
            ),
            SelectableText(
                "The page you were looking for doesn't seem to exist")
          ],
        ),
      ),
    );
  }
}
