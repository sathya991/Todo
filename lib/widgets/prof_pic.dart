import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo/providers/prof_pic_provider.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/widgets/photo_viewer.dart';

class ProfPic extends StatelessWidget {
  const ProfPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic profPic = context.watch<ProfPicProvider>().profPic;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PhotoViewer.photoViewerRoute);
      },
      child: context.watch<ProfPicProvider>().isUploading
          ? Shimmer.fromColors(
              child: CircleAvatar(
                radius: 4.5.h,
              ),
              baseColor: Colors.white,
              highlightColor: BasicUtils().allColor,
            )
          : CircleAvatar(
              backgroundColor: BasicUtils().allColor,
              radius: 4.5.h,
              backgroundImage: context.watch<ProfPicProvider>().profPic),
    );
  }
}
