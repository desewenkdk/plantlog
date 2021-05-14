import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './Data.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class Controller_device_data extends GetxController{
  final _device_info_array = <Model_device_data>[].obs;

  final _bar_graph_data_array = <BarGraphData>[].obs;
  //final _Bar_Data = BarData(barDataList: _bar_graph_data_array);

  final _init_temp_data = BarGraphData(id : 0, name : "temp_stand", y : 65, color : Color(0xffff4d94));
  final _init_humid_data = BarGraphData(id : 0, name : "temp_humid", y : 50, color : Color(0xffff4d94));

  TextEditingController deviceSerialController;
  TextEditingController deviceNameController;
  TextEditingController deviceModelController;
  TextEditingController mock_param_Controller;
  @override
  void onInit(){
    deviceSerialController = TextEditingController();
    deviceNameController = TextEditingController();
    deviceModelController = TextEditingController();
    mock_param_Controller = TextEditingController();

    //first mock data
    _device_info_array.add(
        Model_device_data(
            device_name: "test1",
            device_model: "testdevice1",
            serial_id: "11111111111",
            parameter : Plant_parameter(
                temp : "55",
                humid : "40"
            )
        )
    );

    _bar_graph_data_array.add(_init_humid_data);
    _bar_graph_data_array.add(_init_temp_data);

    update();
    super.onInit();
  }

  void add_new_device(Model_device_data data){
    _device_info_array.add(data);
    print("in ADDNEWDEVICE-------------------"+data.parameter.temp.toString());
    make_Bargraph_data(data);
    update();
  }

  void make_Bargraph_data(Model_device_data data) {

    BarGraphData tempGraphData = new BarGraphData(
        id : _bar_graph_data_array.length,
        name : "temperature", color: Color(0xff19bfff),
        y : data.parameter.temp
    );
    print("TempGraph Y Value--------------------------");
    print(tempGraphData.y);
    _bar_graph_data_array.add(
        tempGraphData
    );
    BarGraphData humidGraphData = new BarGraphData(
        id : _bar_graph_data_array.length,
        name : "humid", color: Color(0xff19bfff),
        y : data.parameter.humid
    );
    _bar_graph_data_array.add(
        humidGraphData
    );
    update();
  }
}

class MyApp extends StatelessWidget {
  //
  //final Controller_device_data _c = Get.put(Controller_device_data());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/add_device', page: () => Add_new_device()),
        GetPage(
          name: '/devicedetail',
          page: () => View_Device_detail(),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  //final Controller_device_data c = Get.put(Controller_device_data());
  final _device_info_array = <Model_device_data>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar : AppBar(
        title : Text("list of devices"),
        actions: [
          //new navigator route with callback func _add_new_device
          IconButton(icon: Icon(Icons.add_box_outlined), onPressed : _add_new_device),
        ],
      ),
      body: _Row_Builder(),
    );
    throw UnimplementedError();
  }
  void _add_new_device(){
    Get.toNamed("/add_device");
  }

  Widget _Row_Builder(){
    Controller_device_data _c = Get.put(Controller_device_data());
    return Container(
      child:
      GetBuilder<Controller_device_data>(
          builder : (_) => ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount : _c._device_info_array.length,
              //itemBuilder를 제공합니다. 이 팩토리 빌더는 익명 함수 형태의 콜백 함수를 받습니다. 두 인자가 함수에 전달됩니다; BuildContext와 행 반복자 i입니다.
              // 반복자는 0부터 시작되고 함수가 호출될 때마다 증가합니다.
              // ListTile에 제안된 모든 단어 쌍에 대해 2번씩, 그리고 Divider에 1번씩 증가합니다. 이 방식을 사용하여 사용자가 스크롤을 할 때마다 목록이 무한하게 증가할 수 있게 할 수 있습니다.
              itemBuilder: /*1*/ (context, i) {
                //return _buildRow(_c._device_info_array[i]);
                return ListTile(
                    title: Text(
                      _c._device_info_array[i].serial_id + ":" + _c._device_info_array[i].device_name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    subtitle: Text(_c._device_info_array[i].parameter.getHumid().toString() + "%," + _c._device_info_array[i].parameter.getTemp().toString() + "F"),
                    onTap: () { //make callback listener for tapping. with annony function
                      Get.toNamed("/devicedetail");
                    }
                );
              },
              separatorBuilder : (context, i){
                return const Divider();
              }
          )
      ),
    );
  }

}

class Add_new_device extends StatelessWidget{
  @override

  //final c = Get.put(Controller_device_data());

  Widget build(BuildContext context) {
    // TODO: implement build
    final c = Get.find<Controller_device_data>();
    return Scaffold(
        appBar : AppBar(
            title : Text('Register New Device')
        ),
        body : Column(
          children : [
            Text("Device Serial"),
            TextField(
                controller : c.deviceSerialController,
                onChanged: (text){
                  print(text);
                },
                maxLength: 14,
                inputFormatters: [LengthLimitingTextInputFormatter(14)],
                decoration : InputDecoration(
                  border : OutlineInputBorder(),
                  labelText : 'SerialNumber',
                )
            ),
            Text("Device Name"),
            TextField(
                controller :c.deviceNameController,
                onChanged : (text){
                  print(text);
                },
                maxLength: 14,
                inputFormatters: [LengthLimitingTextInputFormatter(14)],
                decoration : InputDecoration(
                  border : OutlineInputBorder(),
                  labelText : 'DeviceModelName',
                )
            ),
            Text("Parameter values"),
            TextField(
                controller : c.mock_param_Controller,
                onChanged : (text){
                  print(text);
                },
                maxLength: 14,
                inputFormatters: [LengthLimitingTextInputFormatter(14)],
                decoration : InputDecoration(
                  border : OutlineInputBorder(),
                  labelText : 'mock_params',
                )
            ),
            FloatingActionButton(
                child:Icon(Icons.add_box_outlined), onPressed: (){
              var model = c.deviceNameController.text;
              var serial = c.deviceSerialController.text;
              var param_list = c.mock_param_Controller.text.split(",");

              var temparature = param_list[0];
              var humid = param_list[1];

              c.add_new_device(Model_device_data(device_name : c.deviceNameController.text, serial_id : c.deviceSerialController.text
                  , parameter: Plant_parameter(temp : temparature, humid : humid)));

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Text("Model : $model, Serial : $serial"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/",arguments : {"serial":c.deviceSerialController.text, "device_name":c.deviceNameController
                              .text});
                        },
                        child:Text("Back"),
                      )
                    ],
                  );
                },
              );
            }
            ),

          ],

        )
    );
    throw UnimplementedError();
  }

}




class View_Device_detail extends StatelessWidget {
  // default value - get from server with json later.....
  final double temp_standard = 65;
  final double barWidth = 22;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final controller = Get.find<Controller_device_data>();
    return Scaffold(
        appBar : AppBar(
          title : Text('Detail_information_view'),
        ),
        body : Container(
            child : GetBuilder<Controller_device_data>(
              builder : (_) =>
                  BarChart(
                    BarChartData(
                      alignment : BarChartAlignment.center,
                      maxY : 100, minY : 0, groupsSpace : 12,
                      barTouchData: BarTouchData(enabled : true),
                      barGroups : controller._bar_graph_data_array.map(
                            (data) => BarChartGroupData(
                            x: data.id,
                            barRods: [
                              BarChartRodData(
                                y: data.y,
                                width : barWidth,
                                colors : [data.color],
                                borderRadius: data.y > 0
                                    ? BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                )
                                    : BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              )
                            ]
                        ),
                      ).toList(),

                    ),
                  ),
            )
        )
    );
    throw UnimplementedError();
  }


}
