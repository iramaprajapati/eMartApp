import 'package:emart_app/consts/consts.dart';

class CartController extends GetxController {
  var totalCartPrice = 0.obs;

  calculateCartTotalPrice(cartData) {
    totalCartPrice.value = 0;

    for (var i = 0; i < cartData.length; i++) {
      totalCartPrice.value = totalCartPrice.value +
          int.parse(cartData[i]["totalprice"].toString());
    }
  }
}
