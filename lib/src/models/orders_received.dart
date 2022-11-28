import 'package:wppl/src/util/api_methods_mixin.dart';

class OrderReceivedModel with ApiMethods {
  @override
  String endpoint = "vendor/orders-received";

  DateTime? createdAt;

  String? orderNumber;
  String? orderQuantity;
  String? orderDelivery;
  String? prodNumber;
  String? vendorCode;
  String? quantityReceived;
  String? orderReceiveDate;

  Map<String, dynamic> json = {};

  OrderReceivedModel(
      {this.createdAt,
      this.orderNumber,
      this.orderQuantity,
      this.quantityReceived,
      this.vendorCode,
      this.orderDelivery,
      this.orderReceiveDate,
      this.prodNumber});

  @override
  void fromJson(Map<String, dynamic> json) {
    this.json = Map<String, dynamic>.from(json);
    createdAt = DateTime.parse(json["createdAt"]);

    orderNumber = json["orderNumber"]["orderNumber"];
    orderQuantity = json["orderNumber"]["orderQuantity"];
    orderDelivery = json["orderNumber"]["orderDelivery"];
    prodNumber = json["orderNumber"]["prodNumber"]["prodNumber"];
    vendorCode = json["orderNumber"]["vendorCode"]["vendorCode"];
    quantityReceived = json["quantityReceived"];
    orderReceiveDate = json["orderReceiveDate"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["orderNumber"] = orderNumber;
    data["quantityReceived"] = quantityReceived;
    return data;
  }
}
