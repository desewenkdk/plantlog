
import 'dart:ffi';

import 'dart:ui';
class Plant_parameter {
  double temp;
  double humid;

  double getTemp(){
    return this.temp;
  }

  double getHumid(){
    return this.humid;
  }
  Plant_parameter({
    String temp, String humid
  }){
    this.temp = double.parse(temp);
    this.humid = double.parse(humid);
  }

  factory Plant_parameter.fromJson(Map<String, dynamic> json){
    return new Plant_parameter(
        temp: json['temp'],
        humid: json['humid']);
  }

  Map<String, dynamic> toJson() =>
      {
        'temp' : temp,
        'humid' : humid
      };
}
class Model_device_data {
  String device_name;
  String serial_id;
  String device_model;
  Plant_parameter parameter;


  Model_device_data({
    String device_name,
    String serial_id,
    String device_model,
    Plant_parameter parameter
  }){
    this.device_name = device_name;
    this.device_model = device_model;
    this.serial_id = serial_id;
    this.parameter = parameter;
  }


  factory Model_device_data.fromJson(Map<String, dynamic> json){

    return Model_device_data(
        device_name : json['device_name'],
        serial_id : json['serial_id'],
        device_model : json['device_model'],
        parameter : Plant_parameter.fromJson(json['parameter'])
    );
  }


  Map<String, dynamic> toJson() =>
      {
        'device_name': device_name,
        'serial_id': serial_id,
        'device_model' : device_model
      };
}

class BarData{
  static int interval = 5;
  List<BarGraphData> barDataList;

  BarData({List<BarGraphData> barDataList}){
    this.barDataList = barDataList;
  }
}

class BarGraphData{
  int id;
  String name;
  double y;
  Color color;

  BarGraphData({int id, String name, double y, Color color}){
    this.id = id;
    this.name = name;
    this.y = y;
    this.color = color;
  }
}
