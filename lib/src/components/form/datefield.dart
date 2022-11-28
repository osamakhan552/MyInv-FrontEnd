import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormDatetimeField extends StatefulWidget {
  final String text;
  final void Function(DateTime date) onChange;
  DateTime? initialValue;

  FormDatetimeField(
      {Key? key, required this.text, required this.onChange, this.initialValue})
      : super(key: key);

  @override
  State<FormDatetimeField> createState() => _FormDatetimeFieldState();
}

class _FormDatetimeFieldState extends State<FormDatetimeField> {
  final TextEditingController cntrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cntrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      cntrl.text = DateFormat("dd-MM-yyyy kk:mm").format(widget.initialValue!);
      widget.initialValue = null;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: cntrl,
        decoration: InputDecoration(
          labelText: widget.text,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          fillColor: Colors.blue,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());
          date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          if (date != null) {
            cntrl.text = DateFormat("dd-MM-yyyy kk:mm").format(date);
            widget.onChange(date);
          }

          setState(() {});
        },
      ),
    );
  }
}
