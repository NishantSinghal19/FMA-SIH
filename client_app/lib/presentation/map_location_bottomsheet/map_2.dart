// ignore_for_file: prefer_const_constructors
import 'package:client_app/core/models/stationData_model.dart';
import 'package:client_app/core/utils/color_constant.dart';
import 'package:client_app/core/utils/image_constant.dart';
import 'package:client_app/core/utils/size_utils.dart';
import 'package:client_app/services/ffis_service.dart';
import 'package:client_app/widgets/app_bar/custom_app_bar.dart';
import 'package:client_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  final mapController = MapController(
      initMapWithUserPosition: UserTrackingOption(
    enableTracking: true,
  ));

  var markerMap = <String, dynamic>{};
  late Future<Iterable<StationData>> _stationDataList;

  @override
  void initState() {
    super.initState();

    _stationDataList = getStationListAboveWarning();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.listenerMapSingleTapping.addListener(() async {
        var position = mapController.listenerMapSingleTapping.value;
        if (position != null) {
          await mapController.addMarker(position,
              markerIcon: const MarkerIcon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.blue,
                  size: 48,
                ),
              ));
          var key = '${position.latitude}_${position.longitude}';
          markerMap[key] = markerMap.length.toString();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _stationDataList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var stationDataList = snapshot.data as Iterable<StationData>;
            for (var stationData in stationDataList) {
              var key = '${stationData.lat}_${stationData.lon}';
              markerMap[key] = stationData;
              mapController.addMarker(
                  GeoPoint(
                      latitude: stationData.lat, longitude: stationData.lon),
                  markerIcon: const MarkerIcon(
                    icon: Icon(
                      Icons.pin_drop,
                      color: Colors.red,
                      size: 25,
                    ),
                  ));
            }
          }
          return SafeArea(
              minimum: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Scaffold(
                appBar: CustomAppBar(
                    height: getVerticalSize(55),
                    title: Container(
                        width: getHorizontalSize(111),
                        margin: getMargin(left: 24, top: 25),
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Map\n",
                                  style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(24),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600)),
                            ]),
                            textAlign: TextAlign.left)),
                    actions: [
                      CustomImageView(
                          imagePath: ImageConstant.imgEllipse30840x40,
                          height: getSize(40),
                          width: getSize(40),
                          radius: BorderRadius.circular(getHorizontalSize(20)),
                          margin:
                              getMargin(left: 24, top: 6, right: 24, bottom: 6))
                    ]),
                body: OSMFlutter(
                  controller: mapController,
                  mapIsLoading: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  osmOption: OSMOption(
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
                          color: Colors.green,
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
                    // markerOption: MarkerOption(
                    //     defaultMarker: MarkerIcon(
                    //   icon: Icon(
                    //     Icons.person_pin_circle,
                    //     color: Colors.blue,
                    //     size: 25,
                    //   ),
                    // )),
                  ),
                  onMapIsReady: (isReady) async {
                    if (isReady) {
                      await Future.delayed(const Duration(seconds: 1),
                          () async {
                        await mapController.currentLocation();
                      });
                    }
                  },
                  onGeoPointClicked: (geopoint) {
                    var key = '${geopoint.latitude}_${geopoint.longitude}';
                    late Future<dynamic> _stationData =
                        getStationData(markerMap[key]!.stationCode);
                    late Future<dynamic> _presentWaterLevelData =
                        getPresentWaterLevelData(markerMap[key]!.stationCode);

                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return FutureBuilder(
                              future: Future.wait(
                                  [_stationData, _presentWaterLevelData]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Station Name: ' +
                                                      markerMap[key]!.name,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                ),
                                                Text(
                                                  'Severity Status: ' +
                                                      markerMap[key]!
                                                          .flood_status,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Flood Trend: ' +
                                                      markerMap[key]!.trend,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Highest Flood Level (HFL): ' +
                                                      markerMap[key]!
                                                          .value
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'HFL Attained Date: ' +
                                                      markerMap[key]!.savedAt,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Last Noted Time: ' +
                                                      snapshot.data[1]
                                                          .lastNotedTime,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Present Water Level: ' +
                                                      snapshot.data[1]
                                                          .presentLevel
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'District: ' +
                                                      snapshot.data[0]
                                                          .district,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Divisional Office: ' +
                                                      snapshot.data[0]
                                                          .divisionalOffice,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'River: ' +
                                                      snapshot.data[0].river,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Basin: ' +
                                                      snapshot.data[0].basin,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: const Icon(Icons.clear),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              });
                        });
                  },
                ),
              ));
        });
  }
}
