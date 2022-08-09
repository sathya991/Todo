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

class ProfPicProvider extends ChangeNotifier {
  String _profPicUrl = "";
  String curUserUid = BasicUtils().curUserUid;
  dynamic _profPic = const AssetImage("res/images/defaultProf.png");
  dynamic get profPic => _profPic;
  bool _isUploading = false;
  final storage = FirebaseStorage.instance;
  bool get isUploading => _isUploading;

  downloadProfPic() async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/"profPic"');
    if (!file.existsSync()) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(curUserUid)
          .get()
          .then((value) {
        _profPicUrl = value.get('profPicUrl');
      }).then((value) async {
        if (_profPicUrl != "") {
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
  }

  imagePick(int source) async {
    ImageSource imageSource;
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
    File ftemp = file;
    await ImageCropper.platform.cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.original
        ]).then((value) async {
      if (value != null) {
        _isUploading = true;
        _profPic = FileImage(File(value.path));
        uploadImage(File(value.path));
        notifyListeners();
      }
    });
  }

  loadProfPic() async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/"profPic"');
    if (file.existsSync()) {
      _profPic = FileImage(file);
      notifyListeners();
    }
  }

  deleteProfPic() async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/"profPic"');
    if (file.existsSync()) {
      final desertRef = FirebaseStorage.instance.ref('profPics/$curUserUid');
      await desertRef.delete().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(curUserUid)
            .get()
            .then((value) async {
          value.reference.update({'profPicUrl': ""});
          _profPicUrl = "";
          _profPic = const AssetImage("res/images/defaultProf.png");
          file.delete();
          notifyListeners();
        });
      });
    }
  }

  uploadImage(dynamic image) async {
    if (image == null) return;
    final destination = 'profPics/$curUserUid';
    final ref = FirebaseStorage.instance.ref(destination);
    ref.putFile(image).then((p0) async {
      p0.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(curUserUid)
            .update({'profPicUrl': value}).then((value1) async {
          _profPicUrl = value;
          _isUploading = false;
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
          notifyListeners();
        });
      });
    });
  }
}
