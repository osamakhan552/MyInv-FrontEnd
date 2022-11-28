import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String text;
  final String? hinttext;
  final Color? color;
  final void Function(String) onChange;
  final int? maxLine;
  final String Function(String)? errorText;
  const FormTextField(
      {Key? key,
      this.color,
      this.hinttext,
      // this.cntrl,
      required this.text,
      required this.onChange,
      this.maxLine,
      this.errorText})
      : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  final TextEditingController cntrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cntrl.dispose();
  }

  String? get _errorText {
    return widget.errorText?.call(cntrl.text);
  }

  @override
  Widget build(BuildContext context) {
    cntrl.text = widget.hinttext ?? "";
    return SizedBox(
      // height: 100,
      width: 200,
      child: TextFormField(
        controller: cntrl,
        keyboardType: TextInputType.multiline,
        maxLines: widget.maxLine,
        minLines: 1,
        onChanged: widget.onChange,
        decoration: InputDecoration(
          labelText: widget.text,
          errorText: _errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          fillColor: widget.color ?? Colors.blue,
        ),
      ),
    );
  }
}
