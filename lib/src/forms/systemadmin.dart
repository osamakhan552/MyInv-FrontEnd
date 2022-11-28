import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/constant.dart';
import '../components/form/button.dart';
import '../components/form/textfield.dart';

class SystemAdminForm extends StatelessWidget {
  const SystemAdminForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "System Admin form",
      ),
      body: Column(
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.start,
            runSpacing: 10.0,
            spacing: 20.0,
            children: [
              SizedBox(
                width: 500,
                child: FormTextField(
                    text: "Add New Role",
                    onChange: (value) {
                      print(value);
                    }),
              ),
              SizedBox(
                width: 500,
                child: FormTextField(
                    text: "Dashboard",
                    onChange: (value) {
                      print(value);
                    }),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormButton(
                  text: "Confirm",
                  color: Colors.green,
                  onPressed: () {
                    print("Confirm pressed");
                  }),
              FormButton(
                  text: "Reset",
                  color: kPrimaryColor,
                  onPressed: () {
                    print("Reset pressed");
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
