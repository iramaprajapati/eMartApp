import 'package:emart_app/consts/consts.dart';

Widget detailsCard({width, String? productCount, String? cardTitle}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      productCount!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      cardTitle!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .make();
}
