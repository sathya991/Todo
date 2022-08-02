import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        Navigator.of(context).pushNamed(PhotoViewer.photoViewerRoute,
            arguments:
                "https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2835&q=80");
      },
      child: CircleAvatar(
          backgroundColor: BasicUtils().allColor,
          radius: 35,
          backgroundImage: context.watch<ProfPicProvider>().profPic),
    );
  }
}
