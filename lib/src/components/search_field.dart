import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/textfield.dart';

class SearchField extends StatelessWidget {
  void Function(String value) onSubmit;
  SearchField({Key? key, required this.onSubmit}) : super(key: key);

  String search = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormTextField(
                text: "Search",
                onChange: (value) {
                  search = value;
                }),
          ),
          ElevatedButton(
            onPressed: () => onSubmit(search),
            child: Text("Search"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(179, 215, 167, 2)),
            ),
          )
        ],
      ),
    );
  }
}
