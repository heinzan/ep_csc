import 'package:epcsc/models/user_location.dart';
import 'package:epcsc/routes.dart';
import 'package:epcsc/services/location_service.dart';
import 'package:epcsc/ui/views/add_agent_view.dart';
import 'package:epcsc/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: Routes.getRoutes(),
        home: HomeView(),
      ),
    );
  }
}
