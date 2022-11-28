import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import '../../components/appbar.dart';
import '../../components/form/button.dart';
import '../../components/form/datefield.dart';
import '../../components/form/dropdown.dart';
import '../../components/form/textfield.dart';
import '../../models/customer_model.dart';

final customerModel = CustomerModel();

class CustomerForm extends StatelessWidget {
  CustomerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Customer Entry Table",
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
                    width: 400,
                    child: FormTextField(
                        text: "First Name",
                        onChange: (value) {
                          customerModel.custFname = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Last Name",
                        onChange: (value) {
                          customerModel.custLname = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Phone",
                        onChange: (value) {
                          customerModel.custPhone = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Email",
                        onChange: (value) {
                          customerModel.custEmail = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: MaterialDropDown(onChange: (value) {
                      customerModel.products = value?.prodId;
                    }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Item Quantity",
                        onChange: (value) {
                          customerModel.itemQuantity = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Amount",
                        onChange: (value) {
                          customerModel.amount = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Address",
                        onChange: (value) {
                          customerModel.address = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormDropdown(
                        text: "Message",
                        list: [true, false],
                        onChange: (value) {
                          customerModel.message = value as bool?;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormDatetimeField(
                        text: "Expiry Date",
                        onChange: (value) {
                          customerModel.expiryDate = value;
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
                      onPressed: () async {
                        await customerModel.post();
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
