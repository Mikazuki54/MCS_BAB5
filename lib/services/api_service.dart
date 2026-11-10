import 'package:bab5/models/field_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  static const _baseUrl =
      'https://api.thingspeak.com/channels/3573892/fields';
  static const _readKey = 'I6ACBJ42U78QZXQU ';

  Future<T> _getField<T>(
    int field,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await dio.get(
      '$_baseUrl/$field/last.json',
      queryParameters: {'api_key': _readKey},
    );

    return fromJson(Map<String, dynamic>.from(response.data));
  }

  Future<Field1Model> getField1() =>
      _getField<Field1Model>(1, Field1Model.fromJson);

  Future<Field2Model> getField2() =>
      _getField<Field2Model>(2, Field2Model.fromJson);

  Future<Field3Model> getField3() =>
      _getField<Field3Model>(3, Field3Model.fromJson);
}
