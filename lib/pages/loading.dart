import 'package:flutter/material.dart';

import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Karachi',
        flag: 'pakistan.png',
        apiEndPointUrl: 'Asia/Karachi');
    await instance.getDataFromRestApi();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location' : instance.location,
      'flag': instance.flag,
      'time' : instance.time,
      'isDayTime' : instance.isDayTime
    });
    // setState(() {
    //   time = instance.time;
    // });
  }

  // String time = 'loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
          child: Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
              size: 50.0,
            ),
          )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }
}
