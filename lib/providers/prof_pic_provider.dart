import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/utils/firebase_storage_utils.dart';

class ProfPicProvider extends ChangeNotifier {
  String _profPicUrl = "";
  String curUserUid = BasicUtils().curUserUid;
  dynamic _profPic = const AssetImage("res/images/defaultProf.png");
  dynamic get profPic => _profPic;

  downloadProfPic() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(curUserUid)
        .get()
        .then((value) {
      _profPicUrl = value.get('profPicUrl');
    }).then((value) async {
      if (_profPicUrl != "") {
        final appStorage = await getApplicationDocumentsDirectory();
        final file = File('${appStorage.path}/"profPic"');
        final response = await Dio().get(_profPicUrl,
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                receiveTimeout: 0));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        _profPic = FileImage(file);
      }
      notifyListeners();
    });
  }

  imagePick(int source) async {
    var imageSource;
    if (source == 0) {
      imageSource = ImageSource.gallery;
    } else {
      imageSource = ImageSource.camera;
    }
    final pickedFile =
        await ImagePicker().pickImage(source: imageSource).then((value) async {
      if (value == null) return null;
      final file = File(value.path);
      cropimage(file);
    });
  }

  cropimage(File file) async {
    await ImageCropper.platform.cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.original]).then((value) {
      _profPic = FileImage(file);
      FirebaseStorageUtils().uploadImage(file);
      notifyListeners();
    });
  }

  deleteProfPic() async {
    final desertRef = FirebaseStorage.instance.ref('profPics/$curUserUid');
    await desertRef.delete().then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(curUserUid)
          .get()
          .then((value) async {
        value.data()!.update('profPicUrl', (value) => "");
        _profPicUrl = "";
        _profPic = const AssetImage("res/images/defaultProf.png");
        final appStorage = await getApplicationDocumentsDirectory();
        final file = File('${appStorage.path}/"profPic"');
        file.delete();
        notifyListeners();
      });
    });
  }
}
