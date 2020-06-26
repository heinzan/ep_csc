import 'package:epcsc/ui/views/add_agent_view.dart';
import 'package:epcsc/ui/views/home_view.dart';
import 'package:flutter/material.dart';

class Routes{
  // Route name constants
  static const String HOME = '/list';
  static const String ADDNEWAGENT = '/addNewAgent';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.HOME: (context) => HomeView(),
      Routes.ADDNEWAGENT: (context) => AddAgentView(),
    };
  }
}