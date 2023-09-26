class StationData {
  final String stationCode;
  final double lat;
  final double lon;
  final String name;
  final String flood_status;
  final String trend;
  final String savedAt;
  final double value;

  StationData(
      {required this.stationCode,
      required this.lat,
      required this.lon,
      required this.name,
      required this.flood_status,
      required this.trend,
      required this.value,
      required this.savedAt});

  factory StationData.fromJson(Map<String, dynamic> json) {
    return StationData(
      stationCode: json['stationCode'],
      lat: double.parse(json['lat'].toString()),
      lon: double.parse(json['lon'].toString()),
      name: json['name'],
      flood_status: json['status'] ?? '',
      trend: json['trend'] ?? '',
      value: double.parse(json['value'].toString()),
      savedAt: json['savedAt'],
    );
  }
}