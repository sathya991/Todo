import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:todo/providers/image_provider.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/providers/prof_pic_provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/utils/dashboard_utils.dart';
import 'package:todo/utils/security_utils.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/option_picker.dart';
import 'package:todo/widgets/prof_pic.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:todo/widgets/text_show.dart';

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
    context.read<LoginSignupProvider>().getUserName();
    context.read<ProfPicProvider>().downloadProfPic();
    context.read<TaskProvider>().getUrgentTasks();
    context.read<TaskProvider>().getMediumTasks();
    context.read<TaskProvider>().getLeisureTasks();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: BasicUtils().allColor,
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
            context.watch<RandomImageProvider>().imageUrl == ""
                ? const SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : DrawerHeader(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                    child: const SizedBox(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(context
                                .watch<RandomImageProvider>()
                                .imageUrl))),
                  ),
            DashboardUtils().listTileStyle("Done tasks", () {}),
            DashboardUtils().listTileStyle("Settings", () {}),
            DashboardUtils().listTileStyle(
                "Logout", () => DashboardUtils().logoutFunction(context)),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: BasicUtils().allColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ProfPic(),
                  SizedBox(
                    height: 5,
                  ),
                  TextShow(),
                ],
              ),
            ),
            const Expanded(child: TaskList()),
            const SizedBox(
              height: 40,
            ),
            const OptionPicker(),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    context.read<RandomImageProvider>().getRandomImage();
    _advancedDrawerController.showDrawer();
  }
}
