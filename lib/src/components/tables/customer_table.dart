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
import 'package:wppl/src/components/form/textfield.dart';
import 'package:wppl/src/components/tables/paginated_table.dart';
import 'package:wppl/src/components/tables/source.dart';
import 'package:wppl/src/models/customer_model.dart';

class CustomerTableSource extends TableSource<CustomerModel> {
  @override
  CustomerModel creator() {
    return CustomerModel();
  }

  // this.custId,
  // this.custFname,
  // this.custLname,
  // this.custEmail,
  // this.custPhone,
  // this.address,
  // this.products,
  // this.expiryDate,
  // this.amount,
  // this.message,
  // this.itemQuantity,
  // this.createdAt
  @override
  DataRow? getRow(int index) {
    CustomerModel item = list[index];
    if (index == updateIndex) {
      CustomerModel model = CustomerModel(
        custId: item.custId,
        custFname: item.custFname,
        custLname: item.custLname,
        custEmail: item.custEmail,
        custPhone: item.custPhone,
        address: item.address,
        products: item.products,
        expiryDate: item.expiryDate,
        amount: item.amount,
        message: item.message,
        itemQuantity: item.itemQuantity,
        createdAt: item.createdAt,
      );

      model.json = item.json;

      //For Update
      return DataRow(cells: [
        // employee id, non editable
        // first name
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: '1',
                hinttext: item.custFname,
                onChange: (newcustFname) {
                  model.custFname = newcustFname;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' 2',
                hinttext: item.custEmail,
                onChange: (newcustEmail) {
                  model.custEmail = newcustEmail;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' 3',
                hinttext: item.amount,
                onChange: (newamount) {
                  model.amount = newamount;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' 4',
                hinttext: item.itemQuantity,
                onChange: (newitemQuantity) {
                  model.itemQuantity = newitemQuantity;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' 5',
                hinttext: item.custPhone,
                onChange: (newcustPhone) {
                  model.custPhone = newcustPhone;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' 6',
                hinttext: item.address,
                onChange: (newaddress) {
                  model.address = newaddress;
                }))),

        DataCell(TextButton(
            onPressed: () async {
              item = model;
              // put the data on server
              // we'll implement exception handling later
              await model.put(model.custId ?? "");
              updateItemAt(index, item);
              cancelEditRow();
            },
            child: Text("Update"))),

        DataCell(TextButton(
            onPressed: () {
              cancelEditRow();
            },
            child: Text("Cancel"))),
      ]);
    }
    CustomerModel model = CustomerModel(
      custId: item.custId,
      custFname: item.custFname,
      custLname: item.custLname,
      custEmail: item.custEmail,
      custPhone: item.custPhone,
      address: item.address,
      products: item.products,
      expiryDate: item.expiryDate,
      amount: item.amount,
      message: item.message,
      itemQuantity: item.itemQuantity,
      createdAt: item.createdAt,
    );

    model.json = item.json;

    return DataRow(cells: [
      //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),

      DataCell(SelectableText(item.custFname.toString())),
      DataCell(SelectableText(item.custEmail.toString())),
      DataCell(SelectableText(item.products.toString())),
      DataCell(SelectableText(item.amount.toString())),
      DataCell(SelectableText(item.itemQuantity.toString())),
      DataCell(SelectableText(item.custPhone.toString())),
      DataCell(SelectableText(item.createdAt.toString())),
      DataCell(SelectableText(item.expiryDate.toString())),

      // DataCell(TextButton(
      //   onPressed: () {
      //     editRow(index);
      //   },
      //   child: Text("Edit"),
      // )),
      DataCell(TextButton(
        onPressed: () async {
          // put the data on server
          // we'll implement exception handling later
          await item.delete(item.custId ?? "");
          removeItem(index);
        },
        child: Text("Delete"),
      )),
      //DataCell(SelectableText(""))
    ]);
  }
}

class CustomerTableWrapper extends StatelessWidget {
  CustomerTableWrapper({Key? key}) : super(key: key);

  final source = CustomerTableSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Customer Table"),
      body: PaginatedTable(
        source: source,
        downloadButtonTitle: "Export customers",
        downloadUrl: "vendor/exportVendor",
        columns: const [
          DataColumn(
            label: SelectableText(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Product',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
              label: SelectableText(
            'Amount',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Quantity',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Phone',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Issue Date',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Expiry Date',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          // DataColumn(
          //     label: SelectableText(
          //   'Edit',
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // )),
          DataColumn(
              label: SelectableText(
            'Delete',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class CustomerTable extends StatefulWidget {
  final List<CustomerModel> customers;

  const CustomerTable({Key? key, required this.customers}) : super(key: key);

  @override
  State<CustomerTable> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
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
                  '1',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  '2',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  '3',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  '4',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  '5',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  '6',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                  label: SelectableText(
                '7',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: SelectableText(
                '8',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: SelectableText(
                '9',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: SelectableText(
                '10',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: Iterable<int>.generate(widget.customers.length).map((index) {
              CustomerModel item = widget.customers[index];
              if (index == updateIndex) {
                CustomerModel model = CustomerModel(
                  custId: item.custId,
                  custFname: item.custFname,
                  custLname: item.custLname,
                  custEmail: item.custEmail,
                  custPhone: item.custPhone,
                  address: item.address,
                  products: item.products,
                  expiryDate: item.expiryDate,
                  amount: item.amount,
                  message: item.message,
                  itemQuantity: item.itemQuantity,
                  createdAt: item.createdAt,
                );

                return DataRow(cells: [
                  // employee id, non editable
                  // first name
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: '1',
                          hinttext: item.custFname,
                          onChange: (newcustFname) {
                            model.custFname = newcustFname;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 2',
                          hinttext: item.custEmail,
                          onChange: (newcustEmail) {
                            model.custEmail = newcustEmail;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 3',
                          hinttext: item.amount,
                          onChange: (newamount) {
                            model.amount = newamount;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 4',
                          hinttext: item.itemQuantity,
                          onChange: (newitemQuantity) {
                            model.itemQuantity = newitemQuantity;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 5',
                          hinttext: item.custPhone,
                          onChange: (newcustPhone) {
                            model.custPhone = newcustPhone;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 6',
                          hinttext: item.address,
                          onChange: (newaddress) {
                            model.address = newaddress;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 7',
                          hinttext: item.address,
                          onChange: (newaddress) {
                            model.address = newaddress;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: ' 8',
                          hinttext: item.address,
                          onChange: (newaddress) {
                            model.address = newaddress;
                          }))),

                  DataCell(TextButton(
                      onPressed: () async {
                        item = model;
                        // put the data on server
                        // we'll implement exception handling later
                        model.put(model.custId ?? "");
                        setState(() {
                          // updating ui
                          widget.customers[index] = model;
                          updateIndex = -1;
                        });
                      },
                      child: Text("Update"))),
                  // Dummy widget cause it throws error for not matching column
                  // length

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
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),
                DataCell(SelectableText("hello")),

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
                    item.delete(item.custId ?? "");
                    setState(() {
                      // updating ui
                      widget.customers.removeAt(index);
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
