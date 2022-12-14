// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:apm_ambulance_app/configMaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:apm_ambulance_app/AllScreens/loginScreen.dart';
import 'package:apm_ambulance_app/AllScreens/mainscreen.dart';
import 'package:apm_ambulance_app/main.dart';

class IcePage extends StatefulWidget {
  static const String idScreen = "Emergency";

  @override
  State<IcePage> createState() => _IceScreenState();
}

class _IceScreenState extends State<IcePage> {
  bool isSwitched = false;
  File? image;

  // method for image picker(gallery)
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //method for image picker(Camera)
  Future pickImage1() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  var nature = [
    'Road Accident',
    'Heart Attack',
    'Pregnancy',
    'Snake Bite',
    'COVID 19',
    'Others',
  ];

  String natureDropDown = "Road Accident";

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                SizedBox(
                  height: 100,
                ),
                Image(
                  image: AssetImage("images/apm_logo.png"),
                  height: 50,
                  width: 70,
                ),
                Text("APM",
                    style: TextStyle(
                        fontSize: 45.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700)),
              ]),
              const Divider(
                color: Colors.blue,
                thickness: 3.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.blueAccent,
                  iconSize: 40.0,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.blueAccent,
                                iconSize: 60.0,
                                onPressed: () {
                                  pickImage1();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.people_alt),
                                color: Colors.blueAccent,
                                iconSize: 60.0,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.perm_contact_calendar),
                                color: Colors.blueAccent,
                                iconSize: 60.0,
                                onPressed: () {},
                              ),
                            ]),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Nature of Emergency",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w400)),
                              DropdownButton(
                                value: natureDropDown,
                                underline: Container(
                                  height: 3,
                                  color: Colors.blueAccent, //<-- SEE HERE
                                ),
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                items: nature.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w500)),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    natureDropDown = newValue!;
                                  });
                                },
                              ),
                            ]),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("AUTO SELECT HOSPITAL",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500)),
                              Switch(
                                // thumb color (round icon)
                                activeColor: Color.fromARGB(255, 82, 82, 82),
                                activeTrackColor: Colors.blueAccent,
                                inactiveThumbColor: Colors.blueAccent,
                                inactiveTrackColor:
                                    Color.fromARGB(255, 82, 82, 82),
                                splashRadius: 50.0,
                                // boolean variable value
                                value: isSwitched,
                                // changes the state of the switch
                                onChanged: (value) =>
                                    setState(() => isSwitched = value),
                              ),
                            ]),
                        const SizedBox(
                          height: 80.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,//change color of button
                              foregroundColor: Colors.white,//change text color
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            
                            ),
                            onPressed: () {},
                            child: const SizedBox(
                              height: 50.0,
                              width: 150.0,
                              child: Center(
                                  child: Text(
                                "CALL HELP",
                                style: TextStyle(
                                    fontSize: 24.0, fontFamily: "Brand Bold"),
                              )),
                            )),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 2.0,
                          endIndent: 0,
                        ),

                        // emergency button
                        /* ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,//change color of button
                              foregroundColor: Colors.white,//change text color
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            ),
                            onPressed: () {},
                            child: const SizedBox(
                              width: 130.0,
                              child: Center(
                                  child: Text(
                                "EMERGENCY",
                                style: TextStyle(
                                    fontSize: 20.0, fontFamily: "Brand Bold"),
                              )),
                            )),
                            */
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

//TOAST FUNCTION
  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
