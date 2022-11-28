/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with three columns: name, age, and
// role. The columns are defined by three [DataColumn] objects. The table
// contains three rows of data for three example users, the data for which
// is defined by three [DataRow] objects.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/data_table.png)

import 'package:flutter/material.dart';
import 'package:wppl/src/components/appbar.dart';
import 'package:wppl/src/components/form/textfield.dart';
import 'package:wppl/src/components/tables/paginated_table.dart';
import 'package:wppl/src/components/tables/source.dart';
import 'package:wppl/src/models/orders_received.dart';

class OrderReceivedTableSource extends TableSource<OrderReceivedModel> {
  @override
  OrderReceivedModel creator() {
    return OrderReceivedModel();
  }

  @override
  DataRow? getRow(int index) {
    OrderReceivedModel item = list[index];
    if (index == updateIndex) {
      OrderReceivedModel model = OrderReceivedModel(
        createdAt: item.createdAt,
        orderNumber: item.orderNumber,
        orderDelivery: item.orderDelivery,
        orderQuantity: item.orderQuantity,
        orderReceiveDate: item.orderReceiveDate,
        prodNumber: item.prodNumber,
        vendorCode: item.vendorCode,
        quantityReceived: item.quantityReceived,
      );
      model.json = item.json;

      return DataRow(cells: [
        DataCell(SizedBox(
          width: 100,
          child: SelectableText("${item.json["orderNumber"]["orderNumber"]}"),
        )),
        DataCell(SizedBox(
          width: 100,
          child: SelectableText("${item.orderQuantity}"),
        )),
        DataCell(SizedBox(
          width: 100,
          child: SelectableText("${item.orderDelivery}"),
        )),
        DataCell(SizedBox(
          width: 100,
          child: SelectableText("${item.prodNumber}"),
        )),
        DataCell(SizedBox(
          width: 100,
          child: SelectableText("${item.vendorCode}"),
        )),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Quantity Received',
                hinttext: item.quantityReceived,
                onChange: (value) {
                  model.quantityReceived = value;
                }))),
        DataCell(SizedBox(
          width: 100,
          child: SelectableText("${item.orderReceiveDate}"),
        )),

        ///
        /// Buttons
        ///
        DataCell(TextButton(
            onPressed: () async {
              item = model;
              model.orderNumber = model.json["orderNumber"]["orderId"];
              // put the data on server
              // we'll implement exception handling later
              await model.put(model.json["orderNumber"]["orderId"] ?? "");
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
      DataCell(SelectableText(item.orderQuantity.toString())),
      DataCell(SelectableText(item.orderDelivery.toString())),
      DataCell(SelectableText(item.prodNumber.toString())),
      DataCell(SelectableText(item.vendorCode.toString())),
      DataCell(SelectableText(item.quantityReceived.toString())),
      DataCell(SelectableText(item.orderReceiveDate.toString())),
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
          await item.delete(item.json["orderNumber"]["orderId"] ?? "");
          removeItem(index);
        },
        child: Text("Delete"),
      )),
      //DataCell(SelectableText(""))
    ]);
  }
}

class OrderReceivedTableWrapper extends StatelessWidget {
  OrderReceivedTableWrapper({Key? key}) : super(key: key);

  final source = OrderReceivedTableSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Orders Received Table"),
      body: PaginatedTable(
        source: source,
        downloadButtonTitle: "Export Orders Received",
        downloadUrl: "vendor/exportOrderReceived",
        columns: const [
          DataColumn(
            label: SelectableText(
              'Order Number',
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
              'Order Delievery',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
              label: SelectableText(
            'Material Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Vendor Code',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Quantity Received',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Order Received Date',
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
        ],
      ),
    );
  }
}

// class OrderReceivedTableWrapper extends StatelessWidget {
//   const OrderReceivedTableWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title:SelectableText("Orders Received Table")),
//         body: Center(
//             child: FutureBuilder(
//                 future: getAll<OrderReceivedModel>(
//                     creator: () =>
//                         OrderReceivedModel()), // this fetches the all employe
//                 builder: (context,
//                     AsyncSnapshot<List<OrderReceivedModel>?> snapshot) {
//                   if (snapshot.hasData &&
//                       snapshot.connectionState == ConnectionState.done) {
//                     // print(snapshot.data);
//                     final _ordersreceived = snapshot.data!;

//                     // show the data on table
//                     return OrderReceivedTable(ordersreceived: _ordersreceived);
//                   }
//                   // its loading, show progress indicator
//                   return CircularProgressIndicator();
//                 })));
//   }
// }

/// This is the stateless widget that the main application instantiates.
class OrderReceivedTable extends StatefulWidget {
  final List<OrderReceivedModel> ordersreceived;

  const OrderReceivedTable({Key? key, required this.ordersreceived})
      : super(key: key);

  @override
  State<OrderReceivedTable> createState() => _OrderReceivedTableState();
}

class _OrderReceivedTableState extends State<OrderReceivedTable> {
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
                  'Order Quantity',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Order Delievery',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                  label: SelectableText(
                'Material Number',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Vendor Code',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Quantity Received',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Order Received Date',
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
            rows: Iterable<int>.generate(widget.ordersreceived.length)
                .map((index) {
              OrderReceivedModel item = widget.ordersreceived[index];
              if (index == updateIndex) {
                OrderReceivedModel model = OrderReceivedModel(
                  createdAt: item.createdAt,
                  orderNumber: item.orderNumber,
                  orderDelivery: item.orderDelivery,
                  orderQuantity: item.orderQuantity,
                  orderReceiveDate: item.orderReceiveDate,
                  prodNumber: item.prodNumber,
                  vendorCode: item.vendorCode,
                  quantityReceived: item.quantityReceived,
                );
                model.json = item.json;

                return DataRow(cells: [
                  DataCell(SizedBox(
                    width: 100,
                    child: SelectableText(
                        "${item.json["orderNumber"]["orderNumber"]}"),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: SelectableText("${item.orderQuantity}"),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: SelectableText("${item.orderDelivery}"),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: SelectableText("${item.prodNumber}"),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: SelectableText("${item.vendorCode}"),
                  )),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Quantity Received',
                          hinttext: item.quantityReceived,
                          onChange: (value) {
                            model.quantityReceived = value;
                          }))),
                  DataCell(SizedBox(
                    width: 100,
                    child: SelectableText("${item.orderReceiveDate}"),
                  )),

                  ///
                  /// Buttons
                  ///
                  DataCell(TextButton(
                      onPressed: () {
                        item = model;
                        // put the data on server
                        // we'll implement exception handling later
                        model.put(model.json["orderNumber"]["orderId"] ?? "");
                        setState(() {
                          // updating ui
                          widget.ordersreceived[index] = model;
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
                DataCell(SelectableText(item.orderQuantity.toString())),
                DataCell(SelectableText(item.orderDelivery.toString())),
                DataCell(SelectableText(item.prodNumber.toString())),
                DataCell(SelectableText(item.vendorCode.toString())),
                DataCell(SelectableText(item.quantityReceived.toString())),
                DataCell(SelectableText(item.orderReceiveDate.toString())),
                DataCell(TextButton(
                  onPressed: () {
                    setState(() {
                      updateIndex = index;
                    });
                  },
                  child: Text("Edit"),
                )),
                DataCell(TextButton(
                  onPressed: () {
                    // put the data on server
                    // we'll implement exception handling later
                    item.delete(item.json["orderNumber"]["orderId"] ?? "");
                    setState(() {
                      // updating ui
                      widget.ordersreceived.removeAt(index);
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
