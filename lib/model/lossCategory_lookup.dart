// To parse this JSON data, do
//
//     final lossCategoryLookup = lossCategoryLookupFromJson(jsonString);

import 'dart:convert';

LossCategoryLookup lossCategoryLookupFromJson(String str) => LossCategoryLookup.fromJson(json.decode(str));

String lossCategoryLookupToJson(LossCategoryLookup data) => json.encode(data.toJson());

class LossCategoryLookup {
    LossCategoryLookup({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    dynamic message;
    Data? data;

    factory LossCategoryLookup.fromJson(Map<String, dynamic> json) => LossCategoryLookup(
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
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "count": count,
    };
}

class ListElement {
    ListElement({
        this.id,
        this.code,
        this.name,
    });

    int? id;
    String? code;
    String? name;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["Id"],
        code: json["Code"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "Name": name,
    };
}
