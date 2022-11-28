import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:wppl/src/models/employee_model.dart';
import 'package:wppl/src/models/roles_model.dart';
import 'package:wppl/src/models/vendor_entry_table.dart';

import 'package:wppl/src/models/material_model.dart';

import 'package:wppl/src/models/purchase_order_model.dart';
import 'package:wppl/src/util/util.dart';

class RolesDropDown extends StatelessWidget {
  final Function(RolesModel?)? onChange;
  const RolesDropDown({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<RolesModel>(
      showSearchBox: true,
      label: "Role",
      onFind: (String? filter) async {
        return await getAll(creator: () => RolesModel(), search: filter);
      },
      onChanged: onChange,
      itemAsString: (RolesModel? item) => (item?.roleName ?? ""),

    );
  }
}

class EmployeesDropDown extends StatelessWidget {
  final Function(EmployeeModel?)? onChange;
  const EmployeesDropDown({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<EmployeeModel>(
          showSearchBox: true,
          label: "Employees",
          onFind: (String? filter) async {
            return await getAll(creator: () => EmployeeModel(), search: filter);
          },
          onChanged: onChange,
          itemAsString: (EmployeeModel? item) =>
              (item?.empFname ?? "") +
              " " +
              (item?.empLname ?? "") +
              " : " +
              (item?.json?["roleId"]["roleName"] ?? "NA")),
    );
  }
}

class VendorDropDown extends StatelessWidget {
  final Function(VendorModel?)? onChange;
  const VendorDropDown({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<VendorModel>(
          showSearchBox: true,
          label: "Vendors",
          onFind: (String? filter) async {
            return await getAll(creator: () => VendorModel(), search: filter);
          },
          onChanged: onChange,
          itemAsString: (VendorModel? item) =>
              (item?.vendorName ?? "") + " : " + (item?.vendorCode ?? "")),
    );
  }
}

class MaterialDropDown extends StatelessWidget {
  final Function(MaterialModel?)? onChange;
  const MaterialDropDown({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<MaterialModel>(
          showSearchBox: true,
          label: "",
          onFind: (String? filter) async {
            return await getAll(creator: () => MaterialModel(), search: filter);
          },
          onChanged: onChange,
          itemAsString: (MaterialModel? item) =>
              (item?.prodName ?? "") + " : " + (item?.prodNumber ?? "")),
    );
  }
}

class MaterialsDropDown extends StatelessWidget {
  final Function(List<MaterialModel>?)? onChange;
  final bool showselecteditems;
  List<MaterialModel>? selecteditems;
  MaterialsDropDown(
      {Key? key,
      required this.onChange,
      this.selecteditems,
      required this.showselecteditems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<MaterialModel>.multiSelection(
        showSearchBox: true,
        showSelectedItems: showselecteditems,
        label: "",
        onFind: (String? filter) async {
          return await getAll<MaterialModel>(creator: () => MaterialModel());
        },
        onChanged: onChange,
        itemAsString: (MaterialModel? item) => (item?.prodName ?? ""),
        // + " : " + (item?.prodId ?? ""),
        selectedItems: selecteditems ?? [],
        compareFn: (item, selectedItem) {
          return item!.prodId == selectedItem!.prodId;
        },
      ),
    );
  }
}

class OrderDropDown extends StatelessWidget {
  final Function(PurchaseOrderModel?)? onChange;
  const OrderDropDown({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<PurchaseOrderModel>(
          showSearchBox: true,
          label: "Orders",
          onFind: (String? filter) async {
            return await getAll(creator: () => PurchaseOrderModel());
          },
          onChanged: onChange,
          itemAsString: (PurchaseOrderModel? item) =>
              (item?.orderNumber ?? "")),
    );
  }
}
