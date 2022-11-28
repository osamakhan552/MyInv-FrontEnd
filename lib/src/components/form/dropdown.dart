import 'package:flutter/material.dart';

class FormDropdown<T> extends StatefulWidget {
  final String text;
  final List<T> list;
  final T? initialValue;
  final void Function(T) onChange;
  T? value;

  FormDropdown({
    Key? key,
    required this.text,
    required this.list,
    required this.onChange,
    this.initialValue,
  }) : super(key: key);

  @override
  State<FormDropdown<T>> createState() => _FormDropdownState<T>();
}

class _FormDropdownState<T> extends State<FormDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SelectableText(
            widget.text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          DropdownButton<T>(
            value: widget.value ?? widget.initialValue,
            hint: widget.value == null
                ? SelectableText(widget.list[0].toString())
                : SelectableText(widget.value.toString()),
            iconSize: 36,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            isExpanded: true,
            items: widget.list
                .map((T item) => DropdownMenuItem<T>(
                      value: item,
                      child: SelectableText(item.toString()),
                    ))
                .toList(),
            onChanged: (T? val) {
              widget.onChange(val!);
              setState(() {
                widget.value = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
