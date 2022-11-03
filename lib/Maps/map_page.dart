import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rakshak_test/Firebase/auth_service.dart';
import 'package:rakshak_test/Maps/config.helper.dart';
import 'package:rakshak_test/Maps/location.helper.dart';
import 'package:rakshak_test/main.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        title: const Text("Maps"),
        backgroundColor: Colors.deepPurple,
        leading: const Icon(
          Icons.home
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await AuthService().signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: "Rakshak"))
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text("Sign out"),
            style: TextButton.styleFrom(
                primary: Colors.white
            ),
          )
        ],
      ),

      body: FutureBuilder(
        future: loadConfigFile(),
        builder: (BuildContext buildContext, AsyncSnapshot<Map<String,dynamic>> snapshot){
          if(snapshot.hasData){
            return MapboxMap(
              accessToken: snapshot.data!['mapbox_api_token'],
              initialCameraPosition: const CameraPosition(target: LatLng(45.45, 45.45)
              ),
              onMapCreated: (MapboxMapController controller) async {
                final location = await acquireCurrentLocation();
                final animateCameraResult = await controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: location!,
                            zoom: 15.0
                        )
                    )
                );

                if(animateCameraResult!){
                  controller.addCircle(
                      CircleOptions(
                          circleRadius: 10.0,
                          circleColor: '#023020',
                          geometry: location
                      )
                  );
                }
              },
            );
          }

          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
