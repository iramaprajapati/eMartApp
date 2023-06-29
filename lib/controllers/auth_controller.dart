import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Text Editing Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login Method
  Future<UserCredential?> loginMethod({required context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Signup Method
  Future<UserCredential?> signupMethod(
      {required String email, required String password, context}) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Storing user data method in Firestore cloud
  storeUserData(
      {required String name,
      required String email,
      required String password}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);

    store.set({
      "Id": currentUser!.uid,
      "name": name,
      "email": email,
      "password": password,
      "profileImgUrl": "",
      "cart_count": "00",
      "wishlist_count": "00",
      "order_count": "00",
    });
  }

  // SignOut Method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
