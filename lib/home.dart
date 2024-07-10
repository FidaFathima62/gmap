import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({
    super.key,
  });

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Location location = Location();

  LocationData? locationData;

   Future<LocationData>getLocate()async{
    locationData=await location.getLocation();
    print(locationData!.latitude);
    return locationData!;
   }
   GoogleMapController? mapController;

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

LatLng center =  LatLng(9.669111, 80.014007);


  @override
  Widget build(BuildContext context) {
    getLocate();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Google Map",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.grey.shade700,
      // ),
      body: FutureBuilder(
        future: getLocate(),
        builder: (context,snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CupertinoActivityIndicator());
          }
          return  Column(
            children: [
              Expanded(
                child: GoogleMap(
                markers: markers.values.toSet(),
trafficEnabled: true,
mapToolbarEnabled: true,
                  compassEnabled: true,
                  myLocationEnabled: true,   
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    zoom: 15,
                    target: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                  ),
                
                ),
              ),
            ], 
          );
        }
      ),
    );
  }
}