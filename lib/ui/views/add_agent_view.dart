import 'package:epcsc/models/user_location.dart';
import 'package:epcsc/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAgentView extends StatelessWidget {
  const AddAgentView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Agent'),
      ),
      body: Center(
        child:
        userLocation == null? Text(LocationService().msg):
        Text(
            'Location: Lat:${userLocation.latitude}, Long: ${userLocation.longitude}'),
      ),

    );
  }
}
