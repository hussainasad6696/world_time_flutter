import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {
  String location; // location name for the ui
  String time;
  String flag;
  String apiEndPointUrl;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.apiEndPointUrl});

  Future<void> getDataFromRestApi() async {
    try {
      Response response = await get(
          Uri.https('worldtimeapi.org', '/api/timezone/$apiEndPointUrl'));
      Map data = jsonDecode(response.body);
      String dateTime = data['datetime'];
      String offSet = data['utc_offset'].substring(1, 3);
      print('$dateTime - $offSet');

      DateTime dateTimeObj = DateTime.parse(dateTime);
      dateTimeObj = dateTimeObj.add(Duration(hours: int.parse(offSet)));

      // time = dateTimeObj.toString();
      time = DateFormat.jm().format(dateTimeObj);
      isDayTime = dateTimeObj.hour > 6 && dateTimeObj.hour < 20 ? true : false;
    } catch (exception) {
      time = '$exception';
    }
  }
}
