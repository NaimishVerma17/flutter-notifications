import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State {
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Notification"),
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: _showNotification,
              child: Text("Trigger one-time notification"),
              textColor: Color(0xFFffffff),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: _repeatNotification,
              child: Text("Trigger repeated notification"),
              textColor: Color(0xFFffffff),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: _scheduleNotification,
              child: Text("Trigger scheduled notification"),
              textColor: Color(0xFFffffff),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id', 'Local notification', 'Fired locally!!',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Title',
        'Hello, this is a test notification!', platformChannelSpecifics,
        payload: 'item x');
  }

  Future _repeatNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id1', 'Local', 'repeating notification');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Title',
        'Hello, this is a test notification!',
        RepeatInterval.EveryMinute,
        platformChannelSpecifics);
  }

  Future _scheduleNotification() async {
    print("Called");
    var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 5));

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id',
        'Channel name',
        'Hello, this is a test notification!',
        icon: 'app_icon',
        largeIcon: 'app_icon',
        largeIconBitmapSource: BitmapSource.Drawable,
        color: const Color.fromARGB(255, 255, 0, 0));
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        2,
        'Local title',
        'Hello, this is a test notification!',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
