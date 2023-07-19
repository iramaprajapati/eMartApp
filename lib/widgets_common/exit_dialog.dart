import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18.0).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure, You want to exit ?"
            .text
            .size(16.0)
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ourButton(
              btnTitle: "Yes",
              btnTextColor: whiteColor,
              btnBgColor: Colors.lightBlue,
              btnOnPressed: () {
                SystemNavigator.pop();
              },
            ),
            ourButton(
              btnTitle: "No",
              btnTextColor: whiteColor,
              btnBgColor: redColor,
              btnOnPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12.0)).roundedSM.make(),
  );
}
