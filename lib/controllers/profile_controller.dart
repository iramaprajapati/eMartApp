import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = "".obs;
  var profileImgLink = "";
  var isLoading = false.obs;

  // Text Editing Controllers
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  // Change Image Method
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      } else {
        profileImgPath.value = img.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // Method to upload profile image on firebase cloud.
  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = "images/${currentUser!.uid}/$filename";
    Reference reference = FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(profileImgPath.value));
    profileImgLink = await reference.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      "name": name,
      //"email": email,
      "password": password,
      "profileImgUrl": imgUrl,
    }, SetOptions(merge: true));
    isLoading(false);
  }
}
