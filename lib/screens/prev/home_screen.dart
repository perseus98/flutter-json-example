import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_serializer_example/serializer/user.dart';
import 'dart:convert';

import 'package:json_serializer_example/serializer/user_new.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // getUser();
    super.initState();
  }

  // getUser() async {
  //   var url = Uri.parse(
  //       'http://192.168.43.234/SerialiableDemo/Get_Serialiable_Data.php');
  //   var response =
  //       await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   print(await http.read(url));
  // }
  getUser() => http.read(Uri.parse('http://192erialiable_Data.php'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getUser(),
          // future: Future.delayed(Duration(seconds: 10)),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error : ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              UserNew userNew =
                  UserNew.fromJsonString(snapshot.data.toString());
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name : ${userNew.name} \n Email : ${userNew.email}"),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text("Refresh"))
                ],
              );
              // return Text("ho gya");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

// // User user = User.fromJson(json.decode(snapshot.data.toString()));
// // List item = [];
// // item = snapshot.data;
// // String name = item[0]['name'];
//
// final decoded = jsonDecode(snapshot.data.toString()) as Map;
//
// // for (final name in decoded.keys) {
// //   final value = decoded['name'];
// //
// //   print('$name,$value'); // prints entries like "AED,3.672940"
// // }
// UserNew userNew = UserNew(decoded['name'], decoded['email']);
//
// //print("test json - " + json.decode(snapshot.data['name']));
//
