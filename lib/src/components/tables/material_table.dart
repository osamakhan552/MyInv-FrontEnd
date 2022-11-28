/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with three columns: name, age, and
// role. The columns are defined by three [DataColumn] objects. The table
// contains three rows of data for three example users, the data for which
// is defined by three [DataRow] objects.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/data_table.png)

import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/dropdown.dart';
import 'package:wppl/src/components/form/textfield.dart';
import 'package:wppl/src/components/tables/paginated_table.dart';
import 'package:wppl/src/components/tables/source.dart';
import 'package:wppl/src/models/material_model.dart';

import '../appbar.dart';

class MaterialTableSource extends TableSource<MaterialModel> {
  @override
  MaterialModel creator() {
    return MaterialModel();
  }

  @override
  DataRow? getRow(int index) {
    MaterialModel item = list[index];
    if (index == updateIndex) {
      MaterialModel model = MaterialModel(
        prodId: item.prodId,
        prodName: item.prodName,
        prodNumber: item.prodNumber,
        quantity: item.quantity,
        amount: item.amount,
        createdAt: item.createdAt,
      );

      return DataRow(cells: [
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Material Name',
                hinttext: item.prodName,
                onChange: (newprodName) {
                  model.prodName = newprodName;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Material Number',
                hinttext: item.prodNumber,
                onChange: (newprodNumber) {
                  model.prodNumber = newprodNumber;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Amount',
                hinttext: item.amount,
                onChange: (newamount) {
                  model.prodNumber = newamount;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Quantity',
                hinttext: item.quantity,
                onChange: (newquantity) {
                  model.quantity = newquantity;
                }))),

        /// Buttons

        DataCell(TextButton(
            onPressed: () async {
              item = model;
              // put the data on server
              // we'll implement exception handling later
              await model.put(model.prodId ?? "");
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

    ///
    /// Now this widget is only to show the data
    /// so all the widgets are Text
    ///
    return DataRow(cells: [
      //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),
      DataCell(SelectableText(item.prodName.toString())),
      DataCell(SelectableText(item.prodNumber.toString())),
      DataCell(SelectableText(item.amount.toString())),
      DataCell(SelectableText(item.quantity.toString())),
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
          await item.delete(item.prodId ?? "");
          removeItem(index);
        },
        child: Text("Delete"),
      )),
      //DataCell(SelectableText(""))
    ]);
  }
}

class MaterialTableWrapper extends StatelessWidget {
  MaterialTableWrapper({Key? key}) : super(key: key);

  final source = MaterialTableSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Material Table"),
      body: PaginatedTable(
        source: source,
        downloadButtonTitle: "Export Materials",
        downloadUrl: "material/exportProduct",
        importButtonTitle: "Import Material",
        importUrl: "material/csv",
        columns: const [
          DataColumn(
            label: SelectableText(
              'Material Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Material Number',
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

/// This is the stateless widget that the main application instantiates.
class MaterialTable extends StatefulWidget {
  final List<MaterialModel> materials;

  const MaterialTable({Key? key, required this.materials}) : super(key: key);

  @override
  State<MaterialTable> createState() => _MaterialTableState();
}

class _MaterialTableState extends State<MaterialTable> {
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
                  'Material Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Material Number',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Material Revision',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                  label: SelectableText(
                'amount',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Quantity',
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
            rows: Iterable<int>.generate(widget.materials.length).map((index) {
              MaterialModel item = widget.materials[index];
              if (index == updateIndex) {
                MaterialModel model = MaterialModel(
                  prodId: item.prodId,
                  prodName: item.prodName,
                  prodNumber: item.prodNumber,
                  quantity: item.quantity,
                  amount: item.amount,
                  createdAt: item.createdAt,
                );

                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Material Name',
                          hinttext: item.prodName,
                          onChange: (newprodName) {
                            model.prodName = newprodName;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Material Number',
                          hinttext: item.prodNumber,
                          onChange: (newprodNumber) {
                            model.prodNumber = newprodNumber;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Amount',
                          hinttext: item.amount,
                          onChange: (newamount) {
                            model.amount = newamount;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Quantity',
                          hinttext: item.quantity,
                          onChange: (newquantity) {
                            model.quantity = newquantity;
                          }))),

                  ///
                  /// Buttons
                  ///
                  DataCell(TextButton(
                      onPressed: () {
                        item = model;
                        // put the data on server
                        // we'll implement exception handling later
                        model.put(model.prodId ?? "");
                        setState(() {
                          // updating ui
                          widget.materials[index] = model;
                          updateIndex = -1;
                        });
                      },
                      child: Text("Update"))),
                  // Dummy widget cause it throws error for not matching column
                  // length

                  //DataCell(SelectableText("")),
                  // DataCell(Text("")),
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
                DataCell(SelectableText(item.prodName.toString())),
                DataCell(SelectableText(item.prodNumber.toString())),
                DataCell(SelectableText(item.quantity.toString())),
                DataCell(SelectableText(item.amount.toString())),
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
                    item.delete(item.prodId ?? "");
                    setState(() {
                      // updating ui
                      widget.materials.removeAt(index);
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
