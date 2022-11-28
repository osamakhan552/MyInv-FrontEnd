import 'package:flutter/material.dart';
import 'package:wppl/src/components/constant.dart';

class TileButton extends StatelessWidget {
  TileButton(
      {Key? key,
      required this.onPressed,
      this.title,
      this.isForm,
      this.icon,
      this.child,
      this.subtitle})
      : super(key: key);

  final VoidCallback onPressed;
  final SelectableText? child;
  String? title;
  bool? isForm;
  Icon? icon;
  String? subtitle;

  @override
  Widget build(BuildContext context) {
    isForm ??= false;
    title ??= "";
    subtitle ??= "";
    icon ??= Icon(
        (isForm!) ? Icons.format_align_left_rounded : Icons.table_view_rounded,
        size: 50);

    return SizedBox(
        width: 200,
        height: 100,
        child: Material(
            elevation: 300,
            shadowColor: Color.fromARGB(255, 0, 0, 0).withAlpha(70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40))),
            child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                leading: icon,
                title: Text(child?.data ?? title!,
                    style: TextStyle(color: Colors.white)),
                onTap: onPressed,
                subtitle: Text(subtitle!,
                    style: TextStyle(
                        color: Colors.grey[50]?.withOpacity(0.5),
                        fontSize: 10)),
                tileColor: kPrimaryColor)));
  }
}
