import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final Widget? child;
  final bool? isButtonDisabled;

  const FormButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.onLongPress,
      this.autofocus,
      this.child,
      this.clipBehavior,
      this.style,
      this.focusNode,
      this.isButtonDisabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: (isButtonDisabled == true) ? null : onPressed,
          onLongPress: onLongPress,
          clipBehavior: clipBehavior ?? Clip.none,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          child: Text(text),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(color ?? Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )))),
    );
  }
}
