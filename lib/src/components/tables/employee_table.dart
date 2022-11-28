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
import 'package:wppl/src/models/employee_model.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import 'package:wppl/src/models/roles_model.dart';

class EmployeeTableSource extends TableSource<EmployeeModel> {
  @override
  EmployeeModel creator() {
    return EmployeeModel();
  }

  @override
  DataRow? getRow(int index) {
    EmployeeModel item = list[index];
    if (index == updateIndex) {
      EmployeeModel model = EmployeeModel(
        username: item.username,
        email: item.email,
        empFname: item.empFname,
        empId: item.empId,
        empLname: item.empLname,
        empPhone: item.empPhone,
        empCbid: item.empCbid,
        isActive: item.isActive,
        roleId: item.roleId,
      );

      return DataRow(cells: [
        // employee id, non editable
        // first name
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'First Name',
                hinttext: item.empFname,
                onChange: (newName) {
                  model.empFname = newName;
                }))),
        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Last Name',
                hinttext: item.empLname,
                onChange: (newName) {
                  model.empLname = newName;
                }))),
        DataCell(SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: RolesDropDown(
                onChange: (value) {
                  model.roleId = value?.roleId;
                },
              ),
            ))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Windal Id',
                hinttext: item.empCbid,
                onChange: (newId) {
                  model.empCbid = newId;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Email Id',
                hinttext: item.email,
                onChange: (newEmail) {
                  model.email = newEmail;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Phone no.',
                hinttext: item.empPhone,
                onChange: (newPhone) {
                  model.empPhone = newPhone;
                }))),

        DataCell(SizedBox(
            width: 100,
            child: FormTextField(
                text: 'Username',
                hinttext: item.username,
                onChange: (newUsername) {
                  model.username = newUsername;
                }))),

        /*DataCell(SizedBox(
                      width: 100,
                      height: 100,
                      child: FormDropdown(
                          text: "is active",
                          list: const [true, false],
                          onChange: (bool? isActive) {
                            model.isActive = isActive;
                          }))),*/

        ///
        /// Buttons
        ///
        DataCell(TextButton(
            onPressed: () async {
              item = model;
              // put the data on server
              // we'll implement exception handling later
              await model.put(model.empId ?? "");
              updateItemAt(index, item);
              cancelEditRow();
            },
            child: Text("Update"))),
        // Dummy widget cause it throws error for not matching column
        // length

        DataCell(TextButton(
            onPressed: () {
              cancelEditRow();
            },
            child: Text("Cancel")))
      ]);
    }

    ///
    /// Now this widget is only to show the data
    /// so all the widgets are Text
    ///
    return DataRow(cells: [
      //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),
      DataCell(SelectableText(item.empFname.toString())),
      DataCell(SelectableText(item.empLname.toString())),
      DataCell(SelectableText(item.json?["roleId"]["roleName"] ?? "NA")),
      DataCell(SelectableText(item.empCbid.toString())),
      DataCell(SelectableText(item.email.toString())),
      DataCell(SelectableText(item.empPhone.toString())),
      // DataCell(SelectableText(item.createdBy.toString())),
      DataCell(SelectableText(item.username.toString())),
      //DataCell(SelectableText(item.isActive.toString())),
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
          await item.delete(item.empId ?? "");
          removeItem(index);
        },
        child: Text("Delete"),
      )),
      //DataCell(SelectableText(""))
    ]);
  }
}

class EmployeeTableWrapper extends StatelessWidget {
  EmployeeTableWrapper({Key? key}) : super(key: key);

  final source = EmployeeTableSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Employee Table"),
      body: PaginatedTable(
        source: source,
        downloadButtonTitle: "Export Employees",
        downloadUrl: "employees/exportEmployee",
        importButtonTitle: "Import Employees",
        importUrl: "employees/csv",
        columns: const [
          DataColumn(
            label: SelectableText(
              'First Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Last Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: SelectableText(
              'Role',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
              label: SelectableText(
            'Windal Id',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Email Id',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Phone no.',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: SelectableText(
            'Username',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          /*DataColumn(
                    label:SelectableText(
                  'Is active',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),*/
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


class EmployeeTable extends StatefulWidget {
  final List<EmployeeModel> employees;

  const EmployeeTable({Key? key, required this.employees}) : super(key: key);

  @override
  State<EmployeeTable> createState() => _EmployeeTableState();
}

class _EmployeeTableState extends State<EmployeeTable> {
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
                  'First Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Last Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: SelectableText(
                  'Role',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                  label: SelectableText(
                'Windal Id',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Email Id',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Phone no.',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              DataColumn(
                  label: SelectableText(
                'Username',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              /*DataColumn(
                  label:SelectableText(
                'Is active',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),*/
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
            rows: Iterable<int>.generate(widget.employees.length).map((index) {
              EmployeeModel item = widget.employees[index];
              if (index == updateIndex) {
                EmployeeModel model = EmployeeModel(
                  username: item.username,
                  email: item.email,
                  empFname: item.empFname,
                  empId: item.empId,
                  empLname: item.empLname,
                  empPhone: item.empPhone,
                  empCbid: item.empCbid,
                  isActive: item.isActive,
                  roleId: item.roleId,
                );

                return DataRow(cells: [
                  // employee id, non editable
                  // first name
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'First Name',
                          hinttext: item.empFname,
                          onChange: (newName) {
                            model.empFname = newName;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Last Name',
                          hinttext: item.empLname,
                          onChange: (newName) {
                            model.empLname = newName;
                          }))),
                  DataCell(SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: RolesDropDown(
                          onChange: (value) {
                            model.roleId = value?.roleId;
                          },
                        ),
                      ))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Windal Id',
                          hinttext: item.empCbid,
                          onChange: (newId) {
                            model.empCbid = newId;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Email Id',
                          hinttext: item.email,
                          onChange: (newEmail) {
                            model.email = newEmail;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Phone no.',
                          hinttext: item.empPhone,
                          onChange: (newPhone) {
                            model.empPhone = newPhone;
                          }))),

                  DataCell(SizedBox(
                      width: 100,
                      child: FormTextField(
                          text: 'Username',
                          hinttext: item.username,
                          onChange: (newUsername) {
                            model.username = newUsername;
                          }))),

             
                  DataCell(TextButton(
                      onPressed: () {
                        item = model;
                        // put the data on server
                        // we'll implement exception handling later
                        model.put(model.empId ?? "");
                        setState(() {
                          // updating ui
                          widget.employees[index] = model;
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
                      child: Text("Cancel")))
                ]);
              }

              ///
              /// Now this widget is only to show the data
              /// so all the widgets are Text
              ///
              return DataRow(cells: [
                //DataCell(SizedBox(width: 50, child:SelectableText(item.empId.toString()))),
                DataCell(SelectableText(item.empFname.toString())),
                DataCell(SelectableText(item.empLname.toString())),
                /*DataCell(SelectableText(RolesModel.roles.toString())),*/
                DataCell(SelectableText(RolesModel.roles
                    .firstWhere((role) => role.roleId == item.roleId,
                        orElse: () => RolesModel(roleName: ""))
                    .roleName
                    .toString())),
                DataCell(SelectableText(item.empCbid.toString())),
                DataCell(SelectableText(item.email.toString())),
                DataCell(SelectableText(item.empPhone.toString())),
                // DataCell(SelectableText(item.createdBy.toString())),
                DataCell(SelectableText(item.username.toString())),
                //DataCell(SelectableText(item.isActive.toString())),
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
                    item.delete(item.empId ?? "");
                    setState(() {
                      // updating ui
                      widget.employees.removeAt(index);
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
