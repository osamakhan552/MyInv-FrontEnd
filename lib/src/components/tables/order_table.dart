/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with three columns: name, age, and
// role. The columns are defined by three [DataColumn] objects. The table
// contains three rows of data for three example users, the data for which
// is defined by three [DataRow] objects.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/data_table.png)

import 'package:flutter/material.dart';
import 'package:wppl/src/components/appbar.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import 'package:wppl/src/components/form/datefield.dart';
import 'package:wppl/src/components/form/textfield.dart';
import 'package:wppl/src/components/tables/paginated_table.dart';
import 'package:wppl/src/components/tables/source.dart';
import 'package:wppl/src/models/purchase_order_model.dart';

class OrderTableSource extends TableSource<PurchaseOrderModel> {
  @override
  PurchaseOrderModel creator() {
    return PurchaseOrderModel();
  }

  @override
  DataRow? getRow(int index) {
    PurchaseOrderModel item = list[index];
    if (index == updateIndex) {
      PurchaseOrderModel model = PurchaseOrderModel(
        orderId: item.orderId,
        orderNumber: item.orderNumber,
        prodNumber: item.json["prodNumber"]["prodId"],
        orderQuantity: item.orderQuantity,
        vendorCode: item.json["vendorCode"]["vendorId"],
        orderDelivery: item.orderDelivery,
        createdAt: item.createdAt,
      );
      model.json = item.json;

      return DataRow(cells: [
        // employee id, non editable
        // first name
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Order Number',
                hinttext: item.orderNumber,
                onChange: (newOrderNo) {
                  model.orderNumber = newOrderNo;
                  item.orderNumber = newOrderNo;
                }))),
        DataCell(SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: MaterialDropDown(onChange: (value) {
                model.prodNumber = value?.prodId;
                item.prodNumber = value?.prodNumber;
              }),
            ))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Order Quantity',
                hinttext: item.orderQuantity,
                onChange: (newQuantity) {
                  model.orderQuantity = newQuantity;
                }))),

        DataCell(SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: VendorDropDown(onChange: (value) {
                model.vendorCode = value?.vendorId;
                item.vendorCode = value?.vendorCode;
              }),
            ))),

        DataCell(SizedBox(
            width: 100,
            child: FormDatetimeField(
                text: 'Order Delievery',
                onChange: (newDelieveryDate) {
                  model.orderDelivery = newDelieveryDate;
                }))),

        ///
        /// Buttons
        ///
        DataCell(TextButton(
            onPressed: () async {
              item = model;
              // put the data on server
              // we'll implement exception handling later
              await model.put(model.orderId ?? "");
              updateItemAt(index, item);
              cancelEditRow();
            },
            child: Text("Update"))),
        // Dummy widget cause it throws error for not matching column
        // length

        //DataCell(SelectableText("")),
        // DataCell(SelectableText("")),
        // DataCell(SelectableText("")),
        DataCell(TextButton(
            onPressed: () {
              cancelEditRow();
            },
            child: Text("Cancel"))),
      ]);
    }

    ///
    /// Now this widget is only to show the data
    /// so all the widgets are Text
    ///
    return DataRow(cells: [
      //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),
      DataCell(SelectableText(item.orderNumber.toString())),
      DataCell(SelectableText(item.prodNumber.toString())),
      DataCell(SelectableText(item.orderQuantity.toString())),
      DataCell(SelectableText(item.vendorCode.toString())),
      DataCell(SelectableText(item.orderDelivery.toString())),
      DataCell(TextButton(
        onPressed: () {
          editRow(index);
        },
        child: Text("Edit"),
      )),
      DataCell(TextButton(
        onPressed: () async {
          // put the data on server
          // we'll implement exception handling later
          await item.delete(item.orderId ?? "");
          removeItem(index);
        },
        child: Text("Delete"),
      )),
      //DataCell(SelectableText(""))
    ]);
  }
}

class OrderTableWrapper extends StatelessWidget {
  OrderTableWrapper({Key? key}) : super(key: key);

  final source = OrderTableSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Purchase Order Table"),
      body: PaginatedTable(
          source: source,
          downloadButtonTitle: "Export Purchase Orders",
          downloadUrl: "vendor/exportOrders",
          columns: const [
            DataColumn(
              label: SelectableText(
                'Order Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: SelectableText(
                'Material No.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: SelectableText(
                'Order Quantity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
                label: SelectableText(
              'Vendor Code',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: SelectableText(
              'Order Delievery',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: SelectableText(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: SelectableText(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ]),
    );
  }
}


//                   return CircularProgressIndicator();
//                 })));
//   }
// }

/// This is the stateless widget that the main application instantiates.
class OrderTable extends StatefulWidget {
  final List<PurchaseOrderModel> orders;

  const OrderTable({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  int updateIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            dataRowHeight: 100,
            sortColumnIndex: _currentSortColumn,
            sortAscending: _isAscending,
            columns: const [
              DataColumn(
                label: SelectableText(
                  'Order Number',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Material No.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Order Quantity',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                  label: SelectableText(
                'Vendor Code',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Order Delievery',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
            ],
            rows: Iterable<int>.generate(widget.orders.length).map((index) {
              PurchaseOrderModel item = widget.orders[index];
              if (index == updateIndex) {
                PurchaseOrderModel model = PurchaseOrderModel(
                  orderId: item.orderId,
                  orderNumber: item.orderNumber,
                  prodNumber: item.json["prodNumber"]["prodId"],
                  orderQuantity: item.orderQuantity,
                  vendorCode: item.json["vendorCode"]["vendorId"],
                  orderDelivery: item.orderDelivery,
                  createdAt: item.createdAt,
                );
                model.json = item.json;

                return DataRow(cells: [
                  // employee id, non editable
                  // first name
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Order Number',
                          hinttext: item.orderNumber,
                          onChange: (newOrderNo) {
                            model.orderNumber = newOrderNo;
                            item.orderNumber = newOrderNo;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: MaterialDropDown(onChange: (value) {
                          model.prodNumber = value?.prodId;
                          item.prodNumber = value?.prodNumber;
                        }),
                      ))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Order Quantity',
                          hinttext: item.orderQuantity,
                          onChange: (newQuantity) {
                            model.orderQuantity = newQuantity;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: VendorDropDown(onChange: (value) {
                          model.vendorCode = value?.vendorId;
                          item.vendorCode = value?.vendorCode;
                        }),
                      ))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormDatetimeField(
                          text: 'Order Delievery',
                          onChange: (newDelieveryDate) {
                            model.orderDelivery = newDelieveryDate;
                          }))),

                  ///
                  /// Buttons
                  ///
                  DataCell(TextButton(
                      onPressed: () async {
                        item = model;
                        // put the data on server
                        // we'll implement exception handling later
                        model.put(model.orderId ?? "");
                        setState(() {
                          // updating ui
                          widget.orders[index] = item;
                          updateIndex = -1;
                        });
                      },
                      child: Text("Update"))),
                  // Dummy widget cause it throws error for not matching column
                  // length

                  //DataCell(SelectableText("")),
                  // DataCell(SelectableText("")),
                  // DataCell(SelectableText("")),
                  DataCell(TextButton(
                      onPressed: () {
                        setState(() {
                          updateIndex = -1;
                        });
                      },
                      child: Text("Cancel"))),
                ]);
              }

              ///
              /// Now this widget is only to show the data
              /// so all the widgets are Text
              ///
              return DataRow(cells: [
                //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),
                DataCell(SelectableText(item.orderNumber.toString())),
                DataCell(SelectableText(item.prodNumber.toString())),
                DataCell(SelectableText(item.orderQuantity.toString())),
                DataCell(SelectableText(item.vendorCode.toString())),
                DataCell(SelectableText(item.orderDelivery.toString())),
                DataCell(TextButton(
                  onPressed: () {
                    setState(() {
                      updateIndex = index;
                    });
                  },
                  child: Text("Edit"),
                )),
                DataCell(TextButton(
                  onPressed: () async {
                    // put the data on server
                    // we'll implement exception handling later
                    item.delete(item.orderId ?? "");
                    setState(() {
                      // updating ui
                      widget.orders.removeAt(index);
                      updateIndex = -1;
                    });
                  },
                  child: Text("Delete"),
                )),
                //DataCell(SelectableText(""))
              ]);
            }).toList()),
      ),
    );
  }
}
