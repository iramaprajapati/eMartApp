import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  // get user profile details
  static getUserProfile(uid) {
    return firestore
        .collection(usersCollection)
        .where("Id", isEqualTo: uid)
        .snapshots();
  }
}
