import 'dart:async';

import 'package:epcsc/models/user_location.dart';
import 'package:epcsc/viewmodels/base_viewmodel.dart';
import 'package:location/location.dart';

class HomeViewModel extends BaseViewModel {
  UserLocation _currentLocation;

  var location = Location();
  StreamController<UserLocation> _locationController = StreamController<
      UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  HomeViewModel() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }
}