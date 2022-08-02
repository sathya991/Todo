import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:todo/providers/prof_pic_provider.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:provider/provider.dart';
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
                      color: BasicUtils().allColor, thickness: 0.5)),
              child: PopupMenuButton<int>(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
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
                                color: BasicUtils().allColor, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 7,
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
                                  color: BasicUtils().allColor, fontSize: 17)),
                          const SizedBox(
                            width: 7,
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
          SizedBox(
            height: 750,
            width: 500,
            child: PhotoView(
              imageProvider: context.watch<ProfPicProvider>().profPic,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // ElevatedButton(
          //     style: FormUtils().elevatedButtonStyle(),
          //     onPressed: () {
          //       context.read<ProfPicProvider>()
          //       context
          //           .read<ProfPicProvider>()
          //           .cropimage(context.read<ProfPicProvider>().profPicFile);
          //     },
          //     child: Text(
          //       "Crop",
          //       style: GoogleFonts.rubik(),
          //     )),
        ],
      ),
    );
  }
}
