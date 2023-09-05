// To parse this JSON data, do
//
//     final machinemasterLookupModel = machinemasterLookupModelFromJson(jsonString);

import 'dart:convert';

MachinemasterLookupModel machinemasterLookupModelFromJson(String str) =>
    MachinemasterLookupModel.fromJson(json.decode(str));

String machinemasterLookupModelToJson(MachinemasterLookupModel data) =>
    json.encode(data.toJson());

class MachinemasterLookupModel {
  MachinemasterLookupModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  Data? data;

  factory MachinemasterLookupModel.fromJson(Map<String, dynamic> json) =>
      MachinemasterLookupModel(
        success: json["Success"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  Data({
    this.list,
    this.count,
  });

  List<ListElement>? list;
  int? count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"]!.map((x) => ListElement.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "count": count,
      };
}

class ListElement {
  ListElement({
    this.id,
    this.code,
    this.name,
    this.supervisor,
    this.supervisorName,
    this.locationId,
    this.departmentId,
    this.locationName,
    this.departmentName,
    this.isActive,
    this.image,
    this.section,
  });

  int? id;
  String? code;
  String? name;
  String? supervisor;
  String? supervisorName;
  int? locationId;
  int? departmentId;
  LocationName? locationName;
  DepartmentName? departmentName;
  bool? isActive;
  String? image;
  dynamic section;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["Id"],
        code: json["Code"],
        name: json["Name"],
        supervisor: json["Supervisor"],
        supervisorName: json["SupervisorName"],
        locationId: json["LocationId"],
        departmentId: json["DepartmentId"],
        locationName: locationNameValues.map[json["LocationName"]]!,
        departmentName: departmentNameValues.map[json["DepartmentName"]]!,
        isActive: json["IsActive"],
        image: json["Image"],
        section: json["Section"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "Name": name,
        "Supervisor": supervisor,
        "SupervisorName": supervisorName,
        "LocationId": locationId,
        "DepartmentId": departmentId,
        "LocationName": locationNameValues.reverse[locationName],
        "DepartmentName": departmentNameValues.reverse[departmentName],
        "IsActive": isActive,
        "Image": image,
        "Section": section,
      };
}

enum DepartmentName { MICROWAVE_OVEN, REFRIGERATOR, WATER_DISPENSER }

final departmentNameValues = EnumValues({
  "Microwave Oven": DepartmentName.MICROWAVE_OVEN,
  "Refrigerator": DepartmentName.REFRIGERATOR,
  "Water Dispenser": DepartmentName.WATER_DISPENSER
});

enum LocationName { LOC_1, LOC_2, LOC_3 }

final locationNameValues = EnumValues({
  "LOC-1": LocationName.LOC_1,
  "LOC-2": LocationName.LOC_2,
  "LOC-3": LocationName.LOC_3
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
