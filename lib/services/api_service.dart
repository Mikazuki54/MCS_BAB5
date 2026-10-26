import 'package:bab5/models/field_model.dart';
import 'package:dio/dio.dart';
class ApiService {
  Dio dio = Dio();

  final String readKey = "GJALAA6FCFQWBJ6M";

  String fieldUrl1 = "https://api.thingspeak.com/channels/3550228/fields/1/last.json?api_key=";
  String fieldUrl2 = "https://api.thingspeak.com/channels/3550228/fields/2/last.json?api_key="; 
  String fieldUrl3 = "https://api.thingspeak.com/channels/3550228/fields/3/last.json?api_key="; 


  Future<Field1Model> getField1() async {
    try {
      final response = await dio.get("$fieldUrl1$readKey");
      return Field1Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Field2Model> getField2() async {
    try {
      final response = await dio.get("$fieldUrl2$readKey");
      return Field2Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Field3Model> getField3() async {
    try {
      final response = await dio.get("$fieldUrl3$readKey");
      return Field3Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}