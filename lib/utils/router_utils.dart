import 'package:flutter/material.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/login_signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginSignupScreen());
      case Dashboard.dashboardRoute:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(child: Text("No Page Found")),
      );
    });
  }
}
