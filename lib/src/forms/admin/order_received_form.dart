import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import '../../components/appbar.dart';
import '../../components/form/button.dart';
import '../../components/form/textfield.dart';
import '../../models/orders_received.dart';

final orderReceivedModel = OrderReceivedModel();

class OrderReceivedForm extends StatelessWidget {
  OrderReceivedForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Received Order Form",
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
                    child: OrderDropDown(
                      onChange: (value) =>
                          orderReceivedModel.orderNumber = value?.orderId,
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Quantity Received",
                        onChange: (value) {
                          orderReceivedModel.quantityReceived = value;
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
                        orderReceivedModel.post();
                      }),
                  // FormButton(
                  //     text: "Reset",
                  //     color: kPrimaryColor,
                  //     onPressed: () {
                  //       print("Reset pressed");
                  //     }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
