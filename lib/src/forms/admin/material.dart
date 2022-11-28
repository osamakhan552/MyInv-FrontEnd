import 'package:flutter/material.dart';
import '../../components/appbar.dart';
import '../../components/form/button.dart';
import '../../components/form/dropdown.dart';
import '../../components/form/textfield.dart';
import '../../models/material_model.dart';

final materialModel = MaterialModel();

class MaterialEntry extends StatelessWidget {
  MaterialEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Material Entry Table",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
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
                          text: "Material Number",
                          onChange: (value) {
                            materialModel.prodNumber = value;
                          }),
                    ),
                    SizedBox(
                      width: 500,
                      child: FormTextField(
                          text: "Material Name",
                          onChange: (value) {
                            materialModel.prodName = value;
                          }),
                    ),
                    SizedBox(
                      width: 500,
                      child: FormTextField(
                          text: "amount",
                          onChange: (value) {
                            materialModel.amount = value;
                          }),
                    ),
                    SizedBox(
                      width: 500,
                      child: FormTextField(
                          text: "quantity",
                          onChange: (value) {
                            materialModel.quantity = value;
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
                          materialModel.post();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
