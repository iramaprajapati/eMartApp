import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
          btnTitle: "Continue",
          btnTextColor: whiteColor,
          btnBgColor: redColor,
          btnOnPressed: () {
            if (cartController.addressController.text.isNotEmpty &&
                cartController.cityController.text.isNotEmpty &&
                cartController.stateController.text.isNotEmpty &&
                cartController.pincodeController.text.isNotEmpty &&
                cartController.phoneController.text.isNotEmpty) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill all details correctly !");
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                title: "Address",
                hint: "Address",
                controller: cartController.addressController),
            customTextField(
                title: "City",
                hint: "City",
                controller: cartController.cityController),
            customTextField(
                title: "State",
                hint: "State",
                controller: cartController.stateController),
            customTextField(
                title: "Pin Code",
                hint: "Pin Code",
                controller: cartController.pincodeController),
            customTextField(
                title: "Phone",
                hint: "Phone",
                controller: cartController.phoneController),
          ],
        ),
      ),
    );
  }
}
