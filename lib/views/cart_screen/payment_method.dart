import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/common_widgets.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: cartController.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  btnTitle: "Place my order",
                  btnTextColor: whiteColor,
                  btnBgColor: redColor,
                  btnOnPressed: () async {
                    await cartController.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[cartController.paymentIndex.value],
                        totalAmount: cartController.totalCartPrice.value);

                    await cartController.clearCart();
                    VxToast.show(context, msg: "Order placed successfully !");
                    Get.offAll(const Home());
                  },
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImgList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    cartController.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: cartController.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4.0,
                        )),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsImgList[index],
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          colorBlendMode:
                              cartController.paymentIndex.value == index
                                  ? BlendMode.darken
                                  : BlendMode.color,
                          color: cartController.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        cartController.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                          bottom: 10.0,
                          right: 10.0,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(bold)
                              .size(16.0)
                              .make()
                              .box
                              .color(Colors.black38)
                              .roundedSM
                              //.margin(const EdgeInsets.all(8.0))
                              .padding(const EdgeInsets.all(3.0))
                              .make(),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
