import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';

class CartController extends GetxController {
  var totalCartPrice = 0.obs;
  var paymentIndex = 0.obs;
  var products = [];
  late dynamic productSnapshot;

  // Text Controller for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pincodeController = TextEditingController();
  var phoneController = TextEditingController();

  calculateCartTotalPrice(cartData) {
    totalCartPrice.value = 0;

    for (var i = 0; i < cartData.length; i++) {
      totalCartPrice.value = totalCartPrice.value +
          int.parse(cartData[i]["totalprice"].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      "order_code": "233981237",
      "order_date": FieldValue.serverTimestamp(),
      "order_by": currentUser!.uid,
      "order_by_name": Get.find<HomeController>().userName,
      "order_by_email": currentUser!.email,
      "order_by_address": addressController.text,
      "order_by_state": stateController.text,
      "order_by_city": cityController.text,
      "order_by_phone": phoneController.text,
      "order_by_pincode": pincodeController.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_placed": true,
      "order_confirmed": false,
      "order_delivered": false,
      "order_on_delivery": false,
      "total_amount": totalAmount,
      "orders": FieldValue.arrayUnion(products)
    });
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "color": productSnapshot[i]["color"],
        "img": productSnapshot[i]["img"],
        "qty": productSnapshot[i]["qty"],
        "title": productSnapshot[i]["title"]
      });
    }

    print(products);
  }
}
