import 'package:wppl/src/util/api_methods_mixin.dart';

class EndpointNotSpecified {}

class MaterialModel with ApiMethods {
  @override
  String endpoint = "products";
  DateTime? createdAt; 
  String? prodId;
  String? prodNumber;
  String? prodName;
  String? quantity;
  String? amount;

  MaterialModel({
    this.createdAt,
    this.prodId,
    this.prodNumber,
    this.prodName,
    this.quantity,
    this.amount,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    createdAt = DateTime.parse(json["createdAt"]);
    prodId = json["prodId"];
    prodNumber = json["prodNumber"];
    prodName = json["prodName"];
    quantity = json["quantity"];
    amount = json["amount"];
  }

  @override
  Map<String, dynamic> toJson() => {
        // "createdAt": createdAt?.toIso8601String(),
        // "prodId": prodId,
        "prodNumber": prodNumber,
        "prodName": prodName,
        "quantity":quantity,
        "amount": amount,
        
      };
}
