import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_serializer_example/screens/main/view_screen.dart';
import 'package:json_serializer_example/serializer/user_new.dart';

Uri serverApi =
    Uri.parse('http://192.168.43.234/SerialiableDemo/Get_Serialiable_Data.php');

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var nameTextEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  bool getData = false;
  late UserNew userNew;
  // var response =
  //     await http.post(url, body: {'name': 'lokesh', 'email': 'l@gmail.com'});
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Form(
        child: ListView(
          children: [
            getData
                ? Text("Name : ${userNew.name} :: Email : ${userNew.email} ")
                : Text("add data tos see"),
            TextFormField(
              controller: nameTextEditingController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: emailTextEditingController,
              decoration: InputDecoration(labelText: "Email"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            print("processing data");
            final response = await http.post(
              serverApi,
              body: {
                'name': nameTextEditingController.text,
                'email': emailTextEditingController.text,
              },
            );
            print(response.body);
            print(response.statusCode);

            if (response.statusCode == 200) {
              setState(() {
                getData = true;
                userNew = UserNew.fromJsonString(response.body);
              });
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Something Went Wrong")));
          },
          label: Text("Submit")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
