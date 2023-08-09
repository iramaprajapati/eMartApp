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

//get products according to subcategory
  static getSubCategoryProducts(subcategory) {
    return firestore
        .collection(productsCollection)
        .where("p_subcategory", isEqualTo: subcategory)
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

  // get all orders on profile screen
  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // get all Wishlists on profile screen
  static getAllWishlists() {
    return firestore
        .collection(productsCollection)
        .where("p_wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  // get all Messages on profile screen
  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where("fromId", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // get all cart items,wishlists and orders counts on profile screen
  static getAllCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where("added_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) => value.docs.length),
      firestore
          .collection(productsCollection)
          .where("p_wishlist", arrayContains: currentUser!.uid)
          .get()
          .then((value) => value.docs.length),
      firestore
          .collection(ordersCollection)
          .where("order_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) => value.docs.length),
    ]);
    return res;
  }

// get all Products on home screen
  static getAllProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

// get all Featured Products on home screen
  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where("is_featured", isEqualTo: true)
        .get();
  }

  // get all Featured Products on home screen
  static searchProducts() {
    return firestore.collection(productsCollection).get();
  }
}
