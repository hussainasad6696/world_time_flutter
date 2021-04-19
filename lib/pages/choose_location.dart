import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;
  List<WorldTime> locations = [
    WorldTime(
        location: 'Pakistan',
        flag: 'pakistan.png',
        apiEndPointUrl: 'Asia/Karachi'),
    WorldTime(
        location: 'London', flag: 'uk.png', apiEndPointUrl: 'Europe/London'),
    WorldTime(
        location: 'Athens',
        flag: 'greece.png',
        apiEndPointUrl: 'Europe/Berlin'),
    WorldTime(
        location: 'Cairo', flag: 'egypt.png', apiEndPointUrl: 'Africa/Cairo'),
    WorldTime(
        location: 'Nairobi',
        flag: 'kenya.png',
        apiEndPointUrl: 'Africa/Nairobi'),
    WorldTime(
        location: 'Chicago',
        flag: 'usa.png',
        apiEndPointUrl: 'America/Chicago'),
    WorldTime(
        location: 'New York',
        flag: 'usa.png',
        apiEndPointUrl: 'America/New_York'),
    WorldTime(
        location: 'Seoul',
        flag: 'south_korea.png',
        apiEndPointUrl: 'Asia/Seoul'),
    WorldTime(
        location: 'Jakarta',
        flag: 'indonesia.png',
        apiEndPointUrl: 'Asia/Jakarta'),
  ];
  bool _saving = false;

  void getTimeFromWorldTimeClass(index) async {
    WorldTime worldTime = locations[index];
    setState(() {
      _saving = true;
    });
    await worldTime.getDataFromRestApi();
    setState(() {
      _saving = false;
    });
    Navigator.pop(context, {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDayTime': worldTime.isDayTime
    });
  }

  Widget _buildWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          child: Card(
            child: ListTile(
              onTap: () {
                getTimeFromWorldTimeClass(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${locations[index].flag}'),
              ),
            ),
          ),
        );
      },
      itemCount: locations.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose Location'),
          elevation: 0,
        ),
        body: ModalProgressHUD(inAsyncCall: _saving, child: _buildWidget()));
  }

  @override
  void initState() {
    super.initState();
  }
}
