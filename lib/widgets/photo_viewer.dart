import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/providers/prof_pic_provider.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/firebase_storage_utils.dart';
import 'package:todo/utils/form_utils.dart';
import 'package:todo/widgets/prof_pic.dart';

class PhotoViewer extends StatelessWidget {
  static const String photoViewerRoute = "/photo-viewer-route";
  const PhotoViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Picture"),
        actions: [
          Theme(
              data: Theme.of(context).copyWith(
                  dividerTheme: DividerThemeData(
                      color: BasicUtils().allColor, thickness: 0.1.h)),
              child: PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1.h))),
                icon: const FaIcon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Text(
                            "Gallery",
                            style: GoogleFonts.rubik(
                                color: BasicUtils().allColor,
                                fontSize: 0.28.dp),
                          ),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          FaIcon(FontAwesomeIcons.file,
                              color: BasicUtils().allColor),
                        ],
                      )),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Text("Camera",
                              style: GoogleFonts.rubik(
                                  color: BasicUtils().allColor,
                                  fontSize: 0.28.dp)),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          FaIcon(FontAwesomeIcons.cameraRetro,
                              color: BasicUtils().allColor),
                        ],
                      ))
                ],
                onSelected: (val) {
                  context.read<ProfPicProvider>().imagePick(val);
                },
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PhotoView(
              imageProvider: context.watch<ProfPicProvider>().profPic,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 4.h),
            child: ElevatedButton(
                style: FormUtils().elevatedButtonStyle(),
                onPressed: context.watch<ProfPicProvider>().profPic ==
                        const AssetImage("res/images/defaultProf.png")
                    ? () {}
                    : () {
                        context.read<ProfPicProvider>().deleteProfPic();
                      },
                child: const Text(
                  "Remove Profile Picture",
                )),
          ),
        ],
      ),
    );
  }
}
