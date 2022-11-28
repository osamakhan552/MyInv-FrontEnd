import 'package:wppl/src/util/api_methods_mixin.dart';

class RolesModel with ApiMethods {
  @override
  String endpoint = "employees/roles";
  RolesModel({
    this.roleId,
    this.createdBy,
    this.createdAt,
    this.roleName,

  });

  String? roleId;
  String? createdBy;
  DateTime? createdAt;
  String? roleName;


  static List<RolesModel> roles = List.empty(growable: true);

  @override
  void fromJson(Map<String, dynamic> json) {
    roleId = json["roleId"];
    createdBy = json["createdBy"];
    createdAt = DateTime.parse(json["createdAt"]);
    roleName = json["roleName"];
    
  }

  @override
  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "roleName": roleName,
   
      };
}
