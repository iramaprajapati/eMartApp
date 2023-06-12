import 'package:emart_app/consts/consts.dart';

Widget applogoWidget() {
  // Using velocity_x here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
