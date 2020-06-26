import 'dart:async';

import 'package:epcsc/models/user_location.dart';
import 'package:epcsc/viewmodels/base_viewmodel.dart';
import 'package:location/location.dart';

class LocationService extends BaseViewModel {
  String msg = 'Permission Require';
  // Keep track of current Location
  UserLocation _currentLocation;
  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  // Continuously emit location updates
  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((_locationData) {
          if (_locationData != null) {
            _locationController.add(UserLocation(
              latitude: _locationData.latitude,
              longitude: _locationData.longitude,
            ));
          }
        });
      }
      else{
        msg = "You have no permission";
      }
    });
  }

  Future<bool> serviceConfirm() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return _serviceEnabled;
      }
    }
    return _serviceEnabled;
  }

  Future<bool> permissionConfirm() async{

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return true;
      }
    }
    return true;
  }

  Future<UserLocation> getLocation() async {

    try {
      if(_serviceEnabled || _permissionGranted==PermissionStatus.granted){
        var userLocation = await location.getLocation();
        _locationController.add(UserLocation(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
        )) ;
      }

    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}