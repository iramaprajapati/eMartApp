import 'package:emart_app/consts/consts.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var userName = "";

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  getUserName() async {
    var n = await firestore
        .collection(usersCollection)
        .where("Id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single["name"];
      }
    });
    userName = n;
    // print("Emart User: $userName");
  }
}
