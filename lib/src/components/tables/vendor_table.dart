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
import 'package:wppl/src/models/vendor_entry_table.dart';

class VendorTableSource extends TableSource<VendorModel> {
  @override
  VendorModel creator() {
    return VendorModel();
  }

  @override
  DataRow? getRow(int index) {
    VendorModel item = list[index];
    if (index == updateIndex) {
      VendorModel model = VendorModel(
        vendorId: item.vendorId,
        vendorCode: item.vendorCode,
        vendorName: item.vendorName,
        vendorPrimaryName: item.vendorPrimaryName,
        vendorPrimaryEmail: item.vendorPrimaryEmail,
        vendorSecondaryEmail: item.vendorSecondaryEmail,
        vendorPrimaryPhone: item.vendorPrimaryPhone,
        vendorSecondaryPhone: item.vendorSecondaryPhone,
        vendorAddress: item.vendorAddress,
        createdAt: item.createdAt,
        materialmodels: item.materialmodels,
      );

      model.json = item.json;

      //For Update
      return DataRow(cells: [
        // employee id, non editable
        // first name
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Code',
                hinttext: item.vendorCode,
                onChange: (newVendorCode) {
                  model.vendorCode = newVendorCode;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Name',
                hinttext: item.vendorName,
                onChange: (newVendorName) {
                  model.vendorName = newVendorName;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Primary Name',
                hinttext: item.vendorPrimaryName,
                onChange: (newVendorPrimaryName) {
                  model.vendorPrimaryName = newVendorPrimaryName;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Primary Email',
                hinttext: item.vendorPrimaryEmail,
                onChange: (newVendorPrimaryEmail) {
                  model.vendorPrimaryEmail = newVendorPrimaryEmail;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Secondary Email',
                hinttext: item.vendorSecondaryEmail,
                onChange: (newVendorSecondaryEmail) {
                  model.vendorSecondaryEmail = newVendorSecondaryEmail;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Primary Phone',
                hinttext: item.vendorPrimaryPhone,
                onChange: (newVendorPrimaryPhone) {
                  model.vendorPrimaryPhone = newVendorPrimaryPhone;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Secondary Phone',
                hinttext: item.vendorSecondaryPhone,
                onChange: (newVendorSecondaryPhone) {
                  model.vendorSecondaryPhone = newVendorSecondaryPhone;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: ' Address',
                hinttext: item.vendorAddress,
                onChange: (newVendorAddress) {
                  model.vendorAddress = newVendorAddress;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: MaterialsDropDown(
                onChange: (value) {
                  List<String> list = [];
                  for (var i in value ?? []) {
                    list.add(i.prodId!);
                  }
                  model.materials = list;
                  model.materialmodels = value;
                },
                showselecteditems: true,
                selecteditems: item.materialmodels))),

        DataCell(TextButton(
            onPressed: () async {
              item = model;
              // put the data on server
              // we'll implement exception handling later
              await model.put(model.vendorId ?? "");
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
    VendorModel model = VendorModel(
        vendorId: item.vendorId,
        vendorCode: item.vendorCode,
        vendorName: item.vendorName,
        vendorPrimaryName: item.vendorPrimaryName,
        vendorPrimaryEmail: item.vendorPrimaryEmail,
        vendorSecondaryEmail: item.vendorSecondaryEmail,
        vendorPrimaryPhone: item.vendorPrimaryPhone,
        vendorSecondaryPhone: item.vendorSecondaryPhone,
        vendorAddress: item.vendorAddress,
        createdAt: item.createdAt,
        materialmodels: item.materialmodels,
      );

      model.json = item.json;

    return DataRow(cells: [
      //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),
      DataCell(SelectableText(item.vendorCode.toString())),
      DataCell(SelectableText(item.vendorName.toString())),
      DataCell(SelectableText(item.vendorPrimaryName.toString())),
      DataCell(SelectableText(item.vendorPrimaryEmail.toString())),
      DataCell(SelectableText(item.vendorPrimaryPhone.toString())),
      DataCell(SelectableText(item.vendorSecondaryEmail.toString())),
      DataCell(SelectableText(item.vendorSecondaryPhone.toString())),
      DataCell(SelectableText(item.vendorAddress.toString())),
      DataCell(SizedBox(
            width: 100,
            child: MaterialsDropDown(
                onChange: (value) {
                  List<String> list = [];
                  for (var i in value ?? []) {
                    list.add(i.prodId!);
                  }
                  model.materials = list;
                  model.materialmodels = value;
                },
                showselecteditems: true,
                selecteditems: item.materialmodels))),
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
          await item.delete(item.vendorId ?? "");
          removeItem(index);
        },
        child: Text("Delete"),
      )),
      //DataCell(SelectableText(""))
    ]);
  }
}

class VendorTableWrapper extends StatelessWidget {
  VendorTableWrapper({Key? key}) : super(key: key);

  final source = VendorTableSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Vendor Table"),
      body: PaginatedTable(
        source: source,
        downloadButtonTitle: "Export Vendors",
        downloadUrl: "vendor/exportVendor",
        columns: const [
          DataColumn(
            label: SelectableText(
              'Code',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Primary Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
              label: SelectableText(
            'Primary Email',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Primary Phone',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Secondary Email',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Secondary Phone',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Materials',
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
class VendorTable extends StatefulWidget {
  final List<VendorModel> vendors;

  const VendorTable({Key? key, required this.vendors}) : super(key: key);

  @override
  State<VendorTable> createState() => _VendorTableState();
}

class _VendorTableState extends State<VendorTable> {
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
                  'Vendor Code',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Vendor Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Vendor Primary Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                  label: SelectableText(
                'Vendor Primary Email',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Vendor Secondary Email',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Vendor Primary Phone',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Vendor Secondary Phone',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Vendor Address',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Materials',
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
            rows: Iterable<int>.generate(widget.vendors.length).map((index) {
              VendorModel item = widget.vendors[index];
              if (index == updateIndex) {
                VendorModel model = VendorModel(
                  vendorId: item.vendorId,
                  vendorCode: item.vendorCode,
                  vendorName: item.vendorName,
                  vendorPrimaryName: item.vendorPrimaryName,
                  vendorPrimaryEmail: item.vendorPrimaryEmail,
                  vendorSecondaryEmail: item.vendorSecondaryEmail,
                  vendorPrimaryPhone: item.vendorPrimaryPhone,
                  vendorSecondaryPhone: item.vendorSecondaryPhone,
                  vendorAddress: item.vendorAddress,
                  createdAt: item.createdAt,
                  materialmodels: item.materialmodels,
                );
             
                return DataRow(cells: [
                  // employee id, non editable
                  // first name
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Code',
                          hinttext: item.vendorCode,
                          onChange: (newVendorCode) {
                            model.vendorCode = newVendorCode;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Name',
                          hinttext: item.vendorName,
                          onChange: (newVendorName) {
                            model.vendorName = newVendorName;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Primary Name',
                          hinttext: item.vendorPrimaryName,
                          onChange: (newVendorPrimaryName) {
                            model.vendorPrimaryName = newVendorPrimaryName;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Primary Email',
                          hinttext: item.vendorPrimaryEmail,
                          onChange: (newVendorPrimaryEmail) {
                            model.vendorPrimaryEmail = newVendorPrimaryEmail;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Secondary Email',
                          hinttext: item.vendorSecondaryEmail,
                          onChange: (newVendorSecondaryEmail) {
                            model.vendorSecondaryEmail =
                                newVendorSecondaryEmail;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Primary Phone',
                          hinttext: item.vendorPrimaryPhone,
                          onChange: (newVendorPrimaryPhone) {
                            model.vendorPrimaryPhone = newVendorPrimaryPhone;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Secondary Phone',
                          hinttext: item.vendorSecondaryPhone,
                          onChange: (newVendorSecondaryPhone) {
                            model.vendorSecondaryPhone =
                                newVendorSecondaryPhone;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Vendor Address',
                          hinttext: item.vendorAddress,
                          onChange: (newVendorAddress) {
                            model.vendorAddress = newVendorAddress;
                          }))),

                  ///
                  /// Buttons
                  ///
                  DataCell(TextButton(
                      onPressed: () async {
                        item = model;
                        // put the data on server
                        // we'll implement exception handling later
                        model.put(model.vendorId ?? "");
                        setState(() {
                          // updating ui
                          widget.vendors[index] = model;
                          updateIndex = -1;
                        });
                      },
                      child: Text("Update"))),
                  // Dummy widget cause it throws error for not matching column
                  // length

                  // DataCell(SelectableText("")),
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
                DataCell(SelectableText(item.vendorCode.toString())),
                DataCell(SelectableText(item.vendorName.toString())),
                DataCell(SelectableText(item.vendorPrimaryName.toString())),
                DataCell(SelectableText(item.vendorPrimaryEmail.toString())),
                DataCell(SelectableText(item.vendorSecondaryEmail.toString())),
                DataCell(SelectableText(item.vendorPrimaryPhone.toString())),
                DataCell(SelectableText(item.vendorSecondaryPhone.toString())),
                DataCell(SelectableText(item.vendorAddress.toString())),
                DataCell(SelectableText("")),

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
                    item.delete(item.vendorId ?? "");
                    setState(() {
                      // updating ui
                      widget.vendors.removeAt(index);
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
