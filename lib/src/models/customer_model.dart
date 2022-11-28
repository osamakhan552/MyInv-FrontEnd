import 'package:wppl/src/util/api_methods_mixin.dart';

class EndpointNotSpecified {}

class CustomerModel with ApiMethods {
  @override
  String endpoint = "customers";
  String? custId;
  String? custFname;
  String? custLname;
  String? custEmail;
  String? custPhone;
  String? address;
  String? products;
  DateTime? expiryDate;
  String? amount;
  bool? message;
  String? itemQuantity;
  DateTime? createdAt;

  CustomerModel(
      {this.custId,
      this.custFname,
      this.custLname,
      this.custEmail,
      this.custPhone,
      this.address,
      this.products,
      this.expiryDate,
      this.amount,
      this.message,
      this.itemQuantity,
      this.createdAt});

  Map<String, dynamic>? json;

  @override
  void fromJson(Map<String, dynamic> json) {
    print("Start");
    this.json = Map.from(json);
    custId = json["custId"];
    print(custId);
    custFname = json["custFname"];
    print(custFname);
    custLname = json["custLname"];
    print(custLname);
    custEmail = json["custEmail"];
    custPhone = json["custPhone"];
    address = json["address"];
    print(address);
    products = json["products"]["prodName"];
    print(products);
    print("before");
    expiryDate = DateTime.parse(json["expiryDate"]);
    print("expiryDAte");
    print(expiryDate);
    amount = json["amount"];
    message = json["message"];

    itemQuantity = json["itemQuantity"];
    print("end");
    createdAt = DateTime.parse(json["createdAt"]);
    print(custFname);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["custFname"] = custFname;
    data["custLname"] = custLname;
    data["custEmail"] = custEmail;
    data["custPhone"] = custPhone;
    data["address"] = address;
    data["products"] = products;
    data["expiryDate"] =
        "${expiryDate?.year.toString().padLeft(4, '0')}-${expiryDate?.month.toString().padLeft(2, '0')}-${expiryDate?.day.toString().padLeft(2, '0')}";
    ;
    data["amount"] = amount;
    data["message"] = message;
    data["itemQuantity"] = itemQuantity;

    print(data);
    return data;
  }
}
