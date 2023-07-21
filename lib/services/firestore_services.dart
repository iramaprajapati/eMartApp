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

  //get cart product details according to current user Id.
  static getCartDetails(uid) {
    return firestore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }

  // Cart product delete document
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // get all chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy("created_on", descending: false)
        .snapshots();
  }
}
