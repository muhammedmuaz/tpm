// To parse this JSON data, do
//
//     final sectionGetmachinebyId = sectionGetmachinebyIdFromJson(jsonString);

import 'dart:convert';

SectionGetmachinebyId sectionGetmachinebyIdFromJson(String str) => SectionGetmachinebyId.fromJson(json.decode(str));

String sectionGetmachinebyIdToJson(SectionGetmachinebyId data) => json.encode(data.toJson());

class SectionGetmachinebyId {
    SectionGetmachinebyId({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    dynamic message;
    List<Datum>? data;

    factory SectionGetmachinebyId.fromJson(Map<String, dynamic> json) => SectionGetmachinebyId(
        success: json["Success"],
        message: json["Message"],
        data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.code,
        this.name,
        this.machineMasterName,
        this.machineMasterId,
        this.image,
        this.tag,
        this.userName,
        this.userId,
        this.isActive,
    });

    int? id;
    String? code;
    String? name;
    dynamic machineMasterName;
    int? machineMasterId;
    String? image;
    dynamic tag;
    String? userName;
    String? userId;
    bool? isActive;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        code: json["Code"],
        name: json["Name"],
        machineMasterName: json["MachineMasterName"],
        machineMasterId: json["MachineMasterId"],
        image: json["Image"],
        tag: json["Tag"],
        userName: json["UserName"],
        userId: json["UserId"],
        isActive: json["IsActive"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "Name": name,
        "MachineMasterName": machineMasterName,
        "MachineMasterId": machineMasterId,
        "Image": image,
        "Tag": tag,
        "UserName": userName,
        "UserId": userId,
        "IsActive": isActive,
    };
}
