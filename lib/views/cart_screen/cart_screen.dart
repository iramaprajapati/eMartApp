import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/cart_screen/shipping_details.dart';
import 'package:emart_app/widgets_common/common_widgets.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
          btnTitle: "Proceed to shipping",
          btnTextColor: whiteColor,
          btnBgColor: redColor,
          btnOnPressed: () {
            Get.to(() => const ShippingDetails());
          },
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Used for removing back buttoon.
        title:
            "E-Mart Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCartDetails(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is Empty !".text.color(darkFontGrey).make(),
            );
          } else {
            var cartData = snapshot.data!.docs;
            cartController.calculateCartTotalPrice(cartData);
            cartController.productSnapshot = cartData;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network("${cartData[index]["img"]}"),
                          title:
                              "${cartData[index]["title"]} ( x${cartData[index]["qty"]} )"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16.0)
                                  .make(),
                          subtitle: "${cartData[index]["totalprice"]}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                          trailing: const Icon(Icons.delete, color: redColor)
                              .onTap(() {
                            FirestoreServices.deleteDocument(
                                cartData[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price :"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${cartController.totalCartPrice.value}"
                            .numCurrency
                            .text
                            .fontFamily(bold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12.0))
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth - 60,
                  //   child: ourButton(
                  //     btnTitle: "Proceed to buy",
                  //     btnTextColor: whiteColor,
                  //     btnBgColor: redColor,
                  //     btnOnPressed: () {},
                  //   ),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
