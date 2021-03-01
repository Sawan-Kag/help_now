import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dataModel.dart';
import 'db_provider.dart';

class DataApiProvider {
  Future<List<Data>> getAllData() async {
    var response = await http.get("https://sigmatenant.com/mobile/tags");
    var body = response.body;
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["tags"];
    return (data).map((employee) {
      print('Inserting $employee');
      DBProvider.db.createdata(Data.fromJson(employee));
    }).toList();
  }
}
