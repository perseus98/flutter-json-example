import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // int i = 0;
  //
  // initState() {
  //   initPref();
  //   super.initState();
  // }
  //
  // initPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   i = prefs.getInt('i') ?? 0;
  // }
  //
  // _incrementCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('i', ++i);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              int i = snapshot.data!.getInt('i') ?? 0;
              print(i);
              return ElevatedButton(
                onPressed: () async {
                  await snapshot.data!.setInt('i', ++i);
                  setState(() {});
                },
                child: Text('Increment Counter : current value => $i'),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
