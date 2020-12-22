import 'package:flutter/material.dart';

import 'package:offer/offers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

double currentSliderValue = 20;
bool shawrma = false;
bool brosted = false;
bool cook = false;
bool bhry = false;
bool all = false;
String km = "km";
String collection = "offers";

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(201, 200, 1552, 2050),
        title: Text("شبعني-الرئيسية"),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text(
                  ": ابحث عن",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                )),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    CheckboxListTile(
                        title: Text(
                          "شاورما",
                          style: TextStyle(color: Colors.black),
                        ),
                        checkColor: Color.fromRGBO(201, 200, 1552, 2050),
                        value: shawrma,
                        onChanged: (bool nextValue) {
                          setState(() {
                            shawrma = nextValue;
                          });
                        }),
                    CheckboxListTile(
                        title: Text(
                          "بروستد",
                          style: TextStyle(color: Colors.black),
                        ),
                        checkColor: Color.fromRGBO(201, 200, 1552, 2050),
                        value: brosted,
                        onChanged: (bool nextValue) {
                          setState(() {
                            brosted = nextValue;
                          });
                        }),
                    CheckboxListTile(
                        title: Text(
                          "طبخ",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: cook,
                        checkColor: Color.fromRGBO(201, 200, 1552, 2050),
                        onChanged: (bool nextValue) {
                          setState(() {
                            cook = nextValue;
                          });
                        }),
                    CheckboxListTile(
                        title: Text(
                          "بحري",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: bhry,
                        checkColor: Color.fromRGBO(201, 200, 1552, 2050),
                        onChanged: (bool nextValue) {
                          setState(() {
                            bhry = nextValue;
                          });
                        }),
                    Text(
                        "ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ"),
                    CheckboxListTile(
                        title: Text(
                          "الكل",
                          style: TextStyle(color: Colors.black),
                        ),
                        checkColor: Color.fromRGBO(201, 200, 1552, 2050),
                        value: all,
                        onChanged: (bool nextValue) {
                          setState(() {
                            all = nextValue;
                            bhry = nextValue;
                            shawrma = nextValue;
                            cook = nextValue;
                            brosted = nextValue;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " : على بعد",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Slider(
                  value: currentSliderValue,
                  min: 5,
                  activeColor: Color.fromRGBO(201, 200, 1552, 2050),
                  max: 50,
                  divisions: 1000,
                  label: currentSliderValue.toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Color.fromRGBO(201, 200, 1552, 2050),
                      )),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => maps()));
                  },
                  color: Color.fromRGBO(201, 200, 1552, 2050),
                  child: Text(
                    "      ابحث       ",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
