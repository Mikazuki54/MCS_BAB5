import 'package:bab5/models/field_model.dart';
import 'package:bab5/services/api_service.dart';
import 'package:flutter/material.dart';


class AppProvider extends ChangeNotifier{
  Field1Model? field1model;
  Field2Model? field2model;
  Field3Model? field3model;
  goToNextPage({required BuildContext context, required navigationPage}) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => navigationPage,
      ),
    );
    notifyListeners();
  }

  Future getTemperature() async {
    notifyListeners();
    return field1model = await ApiService().getField1();
  }

  Future getHumidity() async {
    notifyListeners();
    return field2model = await ApiService().getField2();
  }

  Future getSoilMoisture() async {
    notifyListeners();
    return field3model = await ApiService().getField3();
  }
}