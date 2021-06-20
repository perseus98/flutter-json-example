import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_serializer_example/serializer/user_new.dart';

import '../../main.dart';

Uri serverApi =
    Uri.parse('http://192.168.43.234/SerialiableDemo/Get_Serialiable_Data.php');

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: http.read(serverApi),
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
                ],
              );
              // return Text("ho gya");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, RoutePath.addScreen),
          label: Text("Add")),
    );
  }
}
