// To parse this JSON data, do
//
//     final issueTagLookup = issueTagLookupFromJson(jsonString);

import 'dart:convert';

IssueTagLookup issueTagLookupFromJson(String str) =>
    IssueTagLookup.fromJson(json.decode(str));

String issueTagLookupToJson(IssueTagLookup data) => json.encode(data.toJson());

class IssueTagLookup {
  IssueTagLookup({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  Data? data;

  factory IssueTagLookup.fromJson(Map<String, dynamic> json) => IssueTagLookup(
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
    this.detector,
    this.machineId,
    this.machineName,
    this.departmentId,
    this.departmentName,
    this.locationId,
    this.locationName,
    this.supervisor,
    this.userId,
    this.supervisorName,
    this.lossCategoryId,
    this.lossCategoryName,
    this.machineSectionName,
    this.machineSectionId,
    this.remarks,
    this.problemDesc,
    this.fTagStatus,
    this.targetDays,
    this.dateofDetection,
    this.images,
    this.imagesAsg,
  });

  int? id;
  String? detector;
  int? machineId;
  dynamic machineName;
  int? departmentId;
  dynamic departmentName;
  int? locationId;
  dynamic locationName;
  String? supervisor;
  dynamic userId;
  dynamic supervisorName;
  int? lossCategoryId;
  dynamic lossCategoryName;
  dynamic machineSectionName;
  int? machineSectionId;
  Remarks? remarks;
  String? problemDesc;
  FTagStatus? fTagStatus;
  int? targetDays;
  String? dateofDetection;
  List<String>? images;
  dynamic imagesAsg;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["Id"],
        detector: json["Detector"],
        machineId: json["MachineId"],
        machineName: json["MachineName"],
        departmentId: json["DepartmentId"],
        departmentName: json["DepartmentName"],
        locationId: json["LocationId"],
        locationName: json["LocationName"],
        supervisor: json["Supervisor"],
        userId: json["UserId"],
        supervisorName: json["SupervisorName"],
        lossCategoryId: json["LossCategoryId"],
        lossCategoryName: json["LossCategoryName"],
        machineSectionName: json["MachineSectionName"],
        machineSectionId: json["MachineSectionId"],
        remarks: remarksValues.map[json["Remarks"]] ?? Remarks.UNDEFINED,
        problemDesc: json["ProblemDesc"],
        fTagStatus: fTagStatusValues.map[json["FTagStatus"]]!,
        targetDays: json["TargetDays"],
        dateofDetection: json["DateofDetection"],
        images: json["Images"] == null
            ? []
            : List<String>.from(json["Images"]!.map((x) => x)),
        imagesAsg: json["ImagesAsg"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Detector": detector,
        "MachineId": machineId,
        "MachineName": machineName,
        "DepartmentId": departmentId,
        "DepartmentName": departmentName,
        "LocationId": locationId,
        "LocationName": locationName,
        "Supervisor": supervisor,
        "UserId": userId,
        "SupervisorName": supervisorName,
        "LossCategoryId": lossCategoryId,
        "LossCategoryName": lossCategoryName,
        "MachineSectionName": machineSectionName,
        "MachineSectionId": machineSectionId,
        "Remarks": remarksValues.reverse[remarks],
        "ProblemDesc": problemDesc,
        "FTagStatus": fTagStatusValues.reverse[fTagStatus],
        "TargetDays": targetDays,
        "DateofDetection": dateofDetection,
        "Images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "ImagesAsg": imagesAsg,
      };
}

enum FTagStatus { CLOSED, RED, BLUE }

final fTagStatusValues = EnumValues({
  "BLUE": FTagStatus.BLUE,
  "CLOSED": FTagStatus.CLOSED,
  "RED": FTagStatus.RED
});

enum Remarks {
  SWITCH_REPAIR_DONE,
  UNDEFINED,
  TAG_CLOSED,
  BROKEN_SWITCH_REPAIR_WORK_DONE,
  ISSUE_RESOLVED
}

final remarksValues = EnumValues({
  "Broken Switch repair work done": Remarks.BROKEN_SWITCH_REPAIR_WORK_DONE,
  "Issue resolved": Remarks.ISSUE_RESOLVED,
  "Switch repair done": Remarks.SWITCH_REPAIR_DONE,
  "Tag Closed": Remarks.TAG_CLOSED,
  "undefined": Remarks.UNDEFINED
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
