import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  // get user profile details
  static getUserProfile(uid) {
    return firestore
        .collection(usersCollection)
        .where("Id", isEqualTo: uid)
        .snapshots();
  }

//get products according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }
}
