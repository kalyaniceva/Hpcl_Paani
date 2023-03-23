import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart';

import '../model/hpcl_model.dart';

class HpclRepository {
  double distance = 0.0;
  BuildContext context;

  HpclRepository(this.context);

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<String> getCurrentPosition(double latitude, double longitude) async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return "0.0";
    var position = await Geolocator.getCurrentPosition();
    distance = Geolocator.distanceBetween(
          latitude,
          longitude,
          position.latitude,
          position.longitude,
        ) /
        1000;
    return '${distance.roundToDouble()}';
  }

  Future<List<HpclData>> getDetailsFromDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var details = prefs.getString('HPCL_DATA');

    if (details == null) {
      var value = await apiCall();
      return value;
    } else {
      var response = json.decode(details);
      return parseResponse(response);
    }
  }

  Future<List<HpclData>> apiCall() async {
    String url =
        ('https://sheets.googleapis.com/v4/spreadsheets/1rRVmsf-mi_yIkgfs7cBoa_8sXqvwVkFeCxGq_S5OTqI/values/HPCL NH Plotting?key=AIzaSyBHUXiBKPVhsYdj4OI9fmNNSLPZ1ImvDIs');
    Response res = await get(Uri.parse(url));
    var jsondata = json.decode(res.body)['values'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(jsondata);
    prefs.setString('HPCL_DATA', jsonString);
    return parseResponse(jsondata);
  }

  Future<List<HpclData>> parseResponse(List<dynamic> jsondata) async {
    List<HpclData> hpcl = [];
    for (var i = 1; i < jsondata.length; i++) {
      hpcl.add(HpclData(
          marketID: jsondata[i][0],
          outletID: jsondata[i][1],
          petrolBrand: jsondata[i][2],
          petrolOffered: jsondata[i][3],
          dieselBrand: jsondata[i][4],
          dieselOffered: jsondata[i][5],
          district: jsondata[i][6],
          clientID: jsondata[i][7],
          stationName: jsondata[i][8],
          salesArea: jsondata[i][9],
          primaryRoad: jsondata[i][10],
          highwayType: jsondata[i][11],
          city: jsondata[i][12],
          lotFront: jsondata[i][13],
          lotDepth: jsondata[i][14],
          state: jsondata[i][15],
          typeOperation: jsondata[i][16],
          latitudeY: jsondata[i][17],
          longitudeX: jsondata[i][18],
          distanceCalculated: await getCurrentPosition(
              double.parse(jsondata[i][17]), double.parse(jsondata[i][18]))));
    }
    hpcl.sort((a, b) => double.parse(a.distanceCalculated!)
        .compareTo(double.parse(b.distanceCalculated!)));
    return hpcl;
  }
}
