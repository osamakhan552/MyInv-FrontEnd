import 'package:wppl/src/util/api_methods_mixin.dart';
import 'material_model.dart';

class VendorModel with ApiMethods {
  @override
  String endpoint = "vendors";
  String? vendorId;
  String? vendorCode;
  String? vendorName;
  String? vendorAddress;
  String? vendorPrimaryName;
  String? vendorPrimaryEmail;
  String? vendorPrimaryPhone;
  String? vendorSecondaryEmail;
  String? vendorSecondaryName;
  String? vendorSecondaryPhone;
  List<MaterialModel>? materialmodels = [];
  List<String>? materials = [];
  DateTime? createdAt;

  Map<String, dynamic> json = {};

  VendorModel({
    this.createdAt,
    this.vendorId,
    this.vendorCode,
    this.vendorName,
    this.vendorAddress,
    this.vendorPrimaryEmail,
    this.vendorSecondaryEmail,
    this.vendorPrimaryName,
    this.vendorPrimaryPhone,
    this.vendorSecondaryPhone,
    this.materialmodels,
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    this.json = Map<String, dynamic>.from(json);
    createdAt = DateTime.parse(json["createdAt"]);
    vendorId = json["vendorId"];
    vendorCode = json["vendorCode"];
    vendorName = json["vendorName"];
    vendorAddress = json["vendorAddress"];
    vendorPrimaryEmail = json["vendorPrimaryEmail"];
    vendorSecondaryEmail = json["vendorSecondaryEmail"];
    vendorPrimaryName = json["vendorPrimaryName"];
    vendorPrimaryPhone = json["vendorPrimaryPhone"];
    vendorSecondaryPhone = json["vendorSecondaryPhone"];
    if ((json["products"]).length > 0) {
      List<MaterialModel> list = [];
      for (int i = 0; i < (json["products"]).length; i++) {
        final model = MaterialModel();
        model.fromJson((json["products"])[i]);
        list.add(model);
      }
      materialmodels = list;
    } else {
      materialmodels = [];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdAt"] = createdAt?.toIso8601String();
    data["vendorId"] = vendorId;
    data["vendorCode"] = vendorCode;
    data["vendorName"] = vendorName;
    data["vendorAddress"] = vendorAddress;
    data["vendorPrimaryEmail"] = vendorPrimaryEmail;
    data["vendorSecondaryEmail"] = vendorSecondaryEmail;
    data["vendorPrimaryName"] = vendorPrimaryName;
    data["vendorPrimaryPhone"] = vendorPrimaryPhone;
    data["vendorSecondaryPhone"] = vendorSecondaryPhone;
    final materialList = List<String>.empty(growable: true);
    for (MaterialModel material in materialmodels ?? []) {
      materialList.add(material.prodId ?? "");
    }
    data["products"] = materialList;
    print(data);
    return data;
  }
}
