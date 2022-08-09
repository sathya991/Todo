import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import 'package:todo/providers/image_provider.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/providers/prof_pic_provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/done_tasks.dart';
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
    context.read<ProfPicProvider>().loadProfPic();
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
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(1.h)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            context.watch<RandomImageProvider>().imageUrl == ""
                ? Shimmer.fromColors(
                    child: Container(
                      decoration: BoxDecoration(color: BasicUtils().allColor),
                      height: 23.h,
                    ),
                    baseColor: BasicUtils().allColor,
                    highlightColor: Colors.white)
                : DrawerHeader(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5.h),
                    child: const SizedBox(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(context
                                .watch<RandomImageProvider>()
                                .imageUrl))),
                  ),
            DashboardUtils().listTileStyle("Done tasks", () {
              Navigator.of(context).pushNamed(DoneTasks.doneTaskRoute);
            }),
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
              padding: EdgeInsets.fromLTRB(8.w, 3.h, 0.w, 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfPic(),
                  SizedBox(
                    height: 0.7.h,
                  ),
                  const TextShow(),
                ],
              ),
            ),
            const Expanded(child: TaskList()),
            SizedBox(
              height: 5.h,
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
