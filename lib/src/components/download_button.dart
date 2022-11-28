import 'package:flutter/material.dart';
import 'package:wppl/src/components/constant.dart';
import 'package:wppl/src/const.dart';
import 'package:wppl/src/util/util.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({Key? key, required this.title, required this.url})
      : super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        ),
        onPressed: () => downloadFile(baseApiUrl + url),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }
}
