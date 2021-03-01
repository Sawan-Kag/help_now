import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  String id;
  String Name;
  String Date;
  String Mobile;
  String Amount_type;
  String Amount;

  Client({
    this.id,
    this.Name,
    this.Date,
    this.Mobile,
    this.Amount_type,
    this.Amount,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        Name: json["name"],
        Date: json["date"],
        Mobile: json["mobil"],
        Amount_type: json["amount_type"],
        Amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": Name,
        "date": Date,
        "mobil": Mobile,
        "amount_type": [Amount_type],
        "amount": [Amount],
      };
}
