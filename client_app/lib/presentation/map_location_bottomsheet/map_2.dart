// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final mapController = MapController(
    initMapWithUserPosition: UserTrackingOption(
      enableTracking: true,
    )
  );

  var markerMap =<String,String>{};

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.listenerMapSingleTapping.addListener(() async {
        var position = mapController.listenerMapSingleTapping.value;
        if(position!=null){
          await mapController.addMarker(position,markerIcon: const MarkerIcon(
            icon: Icon(Icons.pin_drop,color: Colors.blue, size: 48,),
          ));
          var key = '${position.latitude}_${position.longitude}';
          markerMap[key]= markerMap.length.toString();
        }
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flood Map"),
      ),
      body: OSMFlutter(controller: mapController,
        mapIsLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        osmOption:OSMOption(
              userTrackingOption: UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: ZoomOption(
                  initZoom: 8,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                    icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                    ),
                ),
                directionArrowMarker: MarkerIcon(
                    icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                    ),
                ),
            ),
            roadConfiguration: RoadOption(
                    roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                )
            ),),
            onMapIsReady: (isReady) async{
              if(isReady) {
              await Future.delayed(const Duration(seconds: 1),() async{await mapController.currentLocation();});
              }
            },
            onGeoPointClicked: (geopoint){
              var key= '${geopoint.latitude}_${geopoint.longitude}';
               showModalBottomSheet(context: context, builder: (context){
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Position - ${markerMap[key]}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),),
                            const Divider(thickness: 1,),
                            Text(key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),) 
                          ],
                        ),),
                        GestureDetector(
                          onTap: ()=> Navigator.pop(context),
                          child: const Icon(Icons.clear),
                        )

                      ],
                    ),
                  ),
                );
               });
            },
      ),
    );
  }
}