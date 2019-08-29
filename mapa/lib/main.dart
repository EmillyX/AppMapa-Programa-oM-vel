import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: new Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    List<Marker> allMarkers = [];

    GoogleMapController _controller;

      String endereco;

@override
  void initState() {
    super.initState();

    allMarkers.add(Marker(
        markerId: MarkerId('Meu Marcador'),
        draggable: true,
        onTap: () {
          print('Marcador Tocado');
        },
        position: LatLng(-9.5128, -35.7913)
        )
     );
  }
  @override
  Widget build(BuildContext context) {
        return new Scaffold(
         appBar: AppBar(
          backgroundColor: Colors.black54,
           title: Material(
             borderRadius: BorderRadius.circular(20.0),
             child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Pesquise',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: pesquisa,
                      iconSize: 30.0)),
              onChanged: (val) {
                setState(() {
                  endereco = val;
                });
              },
           ),
           ),
        ),
      body: Stack(
        children: [Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(-9.5128, -35.7913), zoom: 12.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              ),
            ),
          ]
         ),
       );
  }
  pesquisa() {
    Geolocator().placemarkFromAddress(endereco).then((result) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }
   void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}

