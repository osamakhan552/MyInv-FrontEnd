import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import '../../components/appbar.dart';
import '../../components/form/button.dart';
import '../../components/form/textfield.dart';
import '../../models/vendor_entry_table.dart';

final vendorModel = VendorModel();

class VendorForm extends StatelessWidget {
  VendorForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Vendor Entry Table",
      ),
      body: Center(
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
                        text: "Vendor Code",
                        onChange: (value) {
                          vendorModel.vendorCode = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Name",
                        onChange: (value) {
                          vendorModel.vendorName = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Primary Name",
                        onChange: (value) {
                          vendorModel.vendorPrimaryName = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Primary Email",
                        onChange: (value) {
                          vendorModel.vendorPrimaryEmail = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Secondary Email",
                        onChange: (value) {
                          vendorModel.vendorSecondaryEmail = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Primary Phone",
                        onChange: (value) {
                          vendorModel.vendorPrimaryPhone = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Secondary Phone",
                        onChange: (value) {
                          vendorModel.vendorSecondaryPhone = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Vendor Address",
                        onChange: (value) {
                          vendorModel.vendorAddress = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: MaterialsDropDown(
                      onChange: (value) {
                        List<String> list = [];
                        for (var i in value ?? []) {
                          list.add(i.prodId);
                        }
                        vendorModel.materialmodels = value;
                      },
                      showselecteditems: false,
                    ),
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
                        vendorModel.post();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
