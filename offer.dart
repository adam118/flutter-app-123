import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class maps extends StatefulWidget {
  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  //wighet
  Widget Cards;
  Widget _child;
  RippleIndecator() {
    return SpinKitPulse(color: Colors.blueAccent);
  }

  //controllars
  GoogleMapController mapController;

  //varebles
  var currentClient;
  var offer = [];
  double currentSliderValue = 20;
  Position position;
  var currentBearing;
  bool clientsToggle = false;
  bool resetToggle = true;
  bool resetToogle = false;

  //initState
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
    _child = RippleIndecator();
    offers();
    getCurrentLocation();
  }

  //gitting the current location with Geolocator
  void getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      Cards = clientCard(Element);
      _child = mapWighet();
    });
  }

  //cards on the map for xoom in markers
  Widget clientCard(client) {
    return Padding(
        padding: EdgeInsets.only(left: 2.0, top: 10.0),
        child: InkWell(
            onTap: () {
              setState(() {
                currentClient = client;
                currentBearing = 90.0;
              });
              zoomInMarker(client);
            },
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                  height: 100.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: Center(child: Text("522005555555"))),
            )));
  }

  //zoom in markers on tap on the card
  zoomInMarker(client) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
                client['location'].latitude, client['location'].longitude),
            zoom: 17.0,
            bearing: 90.0,
            tilt: 45.0)))
        .then((val) {
      setState(() {
        resetToggle = true;
      });
    });
  }

  //build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                showDialog(
                    context: (context),
                    child: AlertDialog(
                      title: Column(
                        children: [
                          Text("اظهار العروض القريبة مني على بعد "),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => maps()));
                              },
                              color: Color.fromRGBO(201, 200, 1552, 2050),
                              child: Text(
                                "      ابحث       ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            )
          ],
          title: Text("google maps adam"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            _child,
            Positioned(
                top: MediaQuery.of(context).size.height - 250.0,
                left: 10.0,
                child: Container(
                    height: 125.0,
                    width: MediaQuery.of(context).size.width,
                    child: clientsToggle
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(8.0),
                            children: offer.map((element) {
                              return clientCard(element);
                            }).toList(),
                          )
                        : Container(
                            height: 0.1,
                            width: 0.1,
                          )))
          ],
        ));
  }

//get the markers from firebase
  offers() {
    Firestore.instance.collection('offers').snapshots().first.then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          clientsToggle = true;
        });
        for (int i = 0; i < docs.documents.length; i++) {
          initMarker(docs.documents[i].data(), docs.documents[i].documentID);
        }
      }
    });
  }

  //initMarker void to make marker from firebase

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(request, requestId) {
    var MarkerIdVal = requestId;
    final MarkerId markerId = MarkerId(MarkerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(request['location'].latitude, request['location'].longitude),
        infoWindow:
            InfoWindow(title: request['name'], snippet: request['des']));
    setState(() {
      markers[markerId] = marker;
      print(markerId);
    });
  }

  //the main wighet theat the app build on it
  mapWighet() {
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      padding: EdgeInsets.all(250),
      markers: Set<Marker>.of(markers.values),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      ),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          mapController = controller;
        });
      },
    );
  }
}

//finish for the google maps page hope you enjoy 🤗
