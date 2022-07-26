import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/providers/image_provider.dart';
import 'package:todo/utils/basic_style_utils.dart';
import 'package:todo/utils/dashboard_utils.dart';
import 'package:todo/utils/security_utils.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static const String dashboardRoute = '/dashboard-route';
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _advancedDrawerController = AdvancedDrawerController();
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
    String imageUrl = context.watch<RandomImageProvider>().imageUrl;
    return AdvancedDrawer(
      backdropColor: BasicStyleUtils().allColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 200),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
              child: const SizedBox(),
              decoration: BoxDecoration(
                  image: imageUrl == ""
                      ? const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("res/images/defaultImage.jpg"))
                      : DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(imageUrl))),
            ),
            DashboardUtils().listTileStyle("Done tasks", () {}),
            DashboardUtils().listTileStyle("Settings", () {}),
            DashboardUtils().listTileStyle("Logout", () {}),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: const Center(
          child: Text("Dashboard"),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    context.read<RandomImageProvider>().getRandomImage();
    _advancedDrawerController.showDrawer();
  }
}
