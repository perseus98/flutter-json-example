import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPrefs {
  SharedPreferences instance;

  SharedPrefs({required this.instance});

  String? getValue(String key) {
    return instance.getString(key);
  }

  void setValue(String key, String value) {
    instance.setString(key, value);
  }
}

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  init() async {
    SharedPrefs myPrefs =
        SharedPrefs(instance: await SharedPreferences.getInstance());
    var myTemp = 'name3';
    if (myPrefs.getValue(myTemp) == null) {
      print("null");
      myPrefs.setValue(myTemp, "Hello2");
    } else {
      print("Get name : ${myPrefs.getValue(myTemp)}");
    }
    print("executed");
  }

  initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(""),
      ),
    );
  }
}
