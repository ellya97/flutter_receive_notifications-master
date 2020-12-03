import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';
  String _body = '';

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));

  }

  @override
  void initState() {
    _registerOnFirebase();
    getMessage();
    super.initState();


  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('received message');
      setState(() {
        _message = message["notification"]["body"];
        _body = message["notification"]["title"];
        print(_message);
        print(_body);
      }
      );
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() {
        _message = message["notification"]["body"];
        _body = message["notification"]["title"];
      }
      );
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() {
        _message = message["notification"]["body"];
        _body = message["notification"]["title"];
      }
      );
    });


  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifcation Test'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child:  Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("HOME"),
          // ),
          _buildDialog(context),
        ],
      ),

    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Message : '),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Title: $_message"),
          Text("Body: $_body"),
        ],
      ),
      // actions: [
      //   new FlatButton(
      //     child: const Text("Ok"),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ],

    );
  }
}
