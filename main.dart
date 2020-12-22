import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offer/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    //_getCurrentLocation();
  }

  //_getCurrentLocation() {
  //  geolocator
  //      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //      .then((Position position) {
  //    setState(() {
  //      _currentPosition = position;
  //    });
//
  //    _getAddressFromLatLng();
  //  }).catchError((e) {
  //    print(e);
  //  });
  //}
//
  //_getAddressFromLatLng() async {
  //  try {
  //    List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //        _currentPosition.latitude, _currentPosition.longitude);
//
  //    Placemark place = p[0];
//
  //    setState(() {
  //      _currentAddress =
  //          "${place.locality}, ${place.postalCode}, ${place.country}";
  //    });
  //  } catch (e) {
  //    print(e);
  //  }
  //}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Transform.rotate(
                    angle: 50,
                    child: Text("جوعان!؟",
                        style: TextStyle(color: Colors.black, fontSize: 50)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Transform.rotate(
                    angle: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Color.fromRGBO(201, 200, 1552, 2050),
                          )),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Location : $_currentAddress",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor:
                                Color.fromRGBO(201, 200, 1552, 2050),
                            textColor: Colors.white,
                            fontSize: 16.0);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        "يلا ناكل",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                      color: Color.fromRGBO(201, 200, 1552, 2050),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
