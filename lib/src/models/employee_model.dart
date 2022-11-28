import 'package:wppl/src/util/api_methods_mixin.dart';

class EndpointNotSpecified {}

class EmployeeModel with ApiMethods {
  @override
  String endpoint = "employees";
  String? username;
  String? email;
  bool? isActive;
  String? empCbid;
  String? empId;
  String? empFname;
  String? empLname;
  String? empPhone;
  String? createdBy;
  String? roleId;
  String? password;
  String? createdAt;

  EmployeeModel(
      {this.username,
      /*show*/ this.email,
      this.isActive,
      /*show*/ this.empCbid,
      this.empId,
      /*show*/ this.empFname,
      /*show*/ this.empLname,
      /*show*/ this.empPhone,
      this.createdAt,
      this.roleId,
      this.password});

  Map<String, dynamic>? json;

  @override
  void fromJson(Map<String, dynamic> json) {
    this.json = Map.from(json);
    username = json['username'];
    email = json['email'];
    isActive = json['is_active'];
    empCbid = json['empCbid'];
    empId = json['empId'];
    empFname = json['empFname'];
    empLname = json['empLname'];
    empPhone = json['empPhone'];
    roleId = json["roleId"]["roleId"];
    password = json['password'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    // data['is_active'] = isActive;
    data['empCbid'] = empCbid;
    // data['empId'] = empId;
    data['empFname'] = empFname;
    data['empLname'] = empLname;
    data['empPhone'] = empPhone;
    data['roleId'] = roleId;
    print(data);
    return data;
  }
}
