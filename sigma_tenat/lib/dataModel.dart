import 'dart:convert';

List<Data> employeeFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String employeeToJson(List<Data> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  String id;
  String title;
  String displayName;
  String meta;
  String description;

  Data({
    this.id,
    this.title,
    this.displayName,
    this.meta,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"],
      title: json["title"],
      displayName: json["displayName"],
      meta: json["meta"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "displayName": displayName,
        "meta": meta,
        "description": description,
      };
}
