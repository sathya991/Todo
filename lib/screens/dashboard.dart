import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo/utils/security_utils.dart';

class Dashboard extends StatefulWidget {
  static const String dashboardRoute = '/dashboard-route';
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    init();
  }

  String userName = "";
  Future init() async {
    userName = await SecureStorage.getUserName() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            DrawerHeader(
                child: Image.network(
                    "https://images.unsplash.com/photo-1533282960533-51328aa49826?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2742&q=80")),
            Text("Done Tasks"),
            Text("Settings"),
            Text("Logout")
          ],
        )),
        appBar: AppBar(
          title: const Text("Todo"),
        ),
        body: const Center(
          child: Text("Dashboard"),
        ));
  }
}
