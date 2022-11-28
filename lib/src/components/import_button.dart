import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wppl/src/components/constant.dart';
import 'package:wppl/src/const.dart';
import 'package:wppl/src/util/util.dart';

class ImportButton extends StatelessWidget {
  const ImportButton({Key? key, required this.title, required this.url})
      : super(key: key);

  final String title;
  final String url;
  Future<void> temp() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result == null) return;

    PlatformFile file = result.files.first;

    //print(file.bytes.toString());
    importFile(file, url);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        ),
        onPressed: () => temp(),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }
}
