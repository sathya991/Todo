import 'package:flutter/material.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/login_signup.dart';
import 'package:todo/widgets/photo_viewer.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginSignupScreen());
      case Dashboard.dashboardRoute:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case PhotoViewer.photoViewerRoute:
        return MaterialPageRoute(
            builder: (context) => PhotoViewer(
                  imageUrl: args,
                ));
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
