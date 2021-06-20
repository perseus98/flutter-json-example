import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_serializer_example/serializer/user_new.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  bool flag = false;

  late UserNew userNew;

  @override
  void initState() {
    //getUser();
    createUser("Lokesh", "kumar");
    super.initState();
  }

  getUser() async {
    var url = Uri.parse(
        'http://192.168.43.234/SerialiableDemo/Get_Serialiable_Data.php');

    var response =
        await http.post(url, body: {'name': 'lokesh', 'email': 'l@gmail.com'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(url));
    userNew = UserNew.fromJsonString(await http.read(url));
    setState(() {
      flag = true;
    });
  }

  Future<UserNew> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.43.234/SerialiableDemo/Get_Serialiable_Data.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
      }),
    );
    return UserNew.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: flag
              ? Text("Name = ${userNew.name} \n Email = ${userNew.email}")
              : CircularProgressIndicator()),
    );
  }
}
