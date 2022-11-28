import 'package:wppl/src/util/api_methods_mixin.dart';
import 'package:dio/dio.dart';

class PurchaseOrderModel with ApiMethods {
  @override
  String endpoint = "vendors/orders";
  PurchaseOrderModel({
    this.createdAt,
    this.orderId,
    this.orderNumber,
    this.prodNumber,
    this.orderQuantity,
    this.vendorCode,
    this.orderDelivery,
  });

  DateTime? createdAt;
  String? orderId;
  String? orderNumber;
  String? prodNumber;
  String? orderQuantity;
  String? vendorCode;
  DateTime? orderDelivery;

  Map<String, dynamic> json = {};

  Future<List<PurchaseOrderModel>> getAll() async {
    final resp = await Dio(baseOptions).get(endpoint);
    int count = resp.data['count'];
    List<PurchaseOrderModel> list = List.empty(growable: true);
    if (resp.statusCode == 200) {
      for (int i = 0; i < count; i++) {
        final model = PurchaseOrderModel();
        model.fromJson(resp.data['results'][i]);
        list.add(model);
      }
    }

    return list;
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    this.json = Map<String, dynamic>.from(json);
    createdAt = DateTime.parse(json["createdAt"]);
    orderId = json["orderId"];
    orderNumber = json["orderNumber"];
    prodNumber = json["prodNumber"]["prodNumber"];
    orderQuantity = json["orderQuantity"];
    vendorCode = json["vendorCode"]["vendorCode"];
    orderDelivery = DateTime.parse(json["orderDelivery"]);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdAt"] = createdAt?.toIso8601String();
    data["orderId"] = orderId;
    data["orderNumber"] = orderNumber;
    data["prodNumber"] = prodNumber;
    data["orderQuantity"] = orderQuantity;
    data["vendorCode"] = vendorCode;
    data["orderDelivery"] =
        "${orderDelivery?.year.toString().padLeft(4, '0')}-${orderDelivery?.month.toString().padLeft(2, '0')}-${orderDelivery?.day.toString().padLeft(2, '0')}";
    return data;
  }
}
