import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map dataFromLoadingScreen = {};

  @override
  Widget build(BuildContext context) {


    dataFromLoadingScreen = dataFromLoadingScreen.isNotEmpty ? dataFromLoadingScreen : ModalRoute.of(context).settings.arguments;

    bool dayNightCheck = dataFromLoadingScreen['isDayTime'];
    String backgroundImages = dayNightCheck ? 'day.png' : 'night.png';
    Color backgroundColor = dayNightCheck ? Colors.blue : Colors.indigo[700];
    Color textColor = dayNightCheck ? Colors.grey[300] : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$backgroundImages'),
                fit: BoxFit.cover
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () async{
                     dynamic result = await Navigator.pushNamed(context, '/location');
                     setState(() {
                       dataFromLoadingScreen = {
                         'location' : result['location'],
                         'flag' : result['flag'],
                         'time' : result['time'],
                         'isDayTime' : result['isDayTime']
                       };
                     });
                    },
                    icon: Icon(Icons.edit_location,
                    color: textColor,),
                    label: Text('Edit Location',
                    style: TextStyle(
                      color: textColor
                    ),)),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dataFromLoadingScreen['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(
                  dataFromLoadingScreen['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
