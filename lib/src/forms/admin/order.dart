import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import '../../components/appbar.dart';
import '../../components/form/button.dart';
import '../../components/form/datefield.dart';
import '../../components/form/textfield.dart';
import '../../models/purchase_order_model.dart';

class OrderForm extends StatelessWidget {
  OrderForm({Key? key}) : super(key: key);
  final purchaseOrderModel = PurchaseOrderModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Purchase Order",
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
                        text: "Order Number",
                        onChange: (value) {
                          purchaseOrderModel.orderNumber = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: MaterialDropDown(
                      onChange: (value) =>
                          purchaseOrderModel.prodNumber = value?.prodId,
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormTextField(
                        text: "Order Quantity",
                        onChange: (value) {
                          purchaseOrderModel.orderQuantity = value;
                        }),
                  ),
                  SizedBox(
                    width: 500,
                    child: VendorDropDown(
                        onChange: (value) =>
                            purchaseOrderModel.vendorCode = value?.vendorId),
                  ),
                  SizedBox(
                    width: 500,
                    child: FormDatetimeField(
                        text: "Order Delievery",
                        onChange: (value) {
                          purchaseOrderModel.orderDelivery = value;
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
                        purchaseOrderModel.post();
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
