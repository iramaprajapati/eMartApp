import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            // Using velocity_x here
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                //our customTextField widget.
                customTextField(title: name, hint: nameHint),
                customTextField(title: email, hint: emailHint),
                customTextField(title: password, hint: passwordHint),
                customTextField(title: retypePassword, hint: passwordHint),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                      activeColor: redColor,
                      checkColor: whiteColor,
                      value: isCheck,
                      onChanged: (newValue) {
                        setState(() {
                          isCheck = newValue;
                        });
                      },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: "$termsAndConditions & $privacyPolicy",
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
                //our custom button widget.
                ourButton(
                        btnTitle: signup,
                        btnBgColor: isCheck == true ? redColor : lightGrey,
                        btnTextColor: whiteColor,
                        btnOnPressed: () {})
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                // wrapping RichText() into gesture detector of velocity_x
                // RichText(
                //   text: const TextSpan(children: [
                //     TextSpan(
                //       text: alreadyHaveAccount,
                //       style: TextStyle(
                //         fontFamily: bold,
                //         color: fontGrey,
                //       ),
                //     ),
                //     TextSpan(
                //       text: login,
                //       style: TextStyle(
                //         fontFamily: bold,
                //         color: redColor,
                //       ),
                //     ),
                //   ]),
                // ).onTap(() {
                //   Get.back();
                // }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAccount.text.color(fontGrey).make(),
                    login.text
                        .color(redColor)
                        .fontFamily(bold)
                        .make()
                        .onTap(() {
                      Get.back();
                    }),
                  ],
                ),
              ],
            )
                .box
                .white
                .rounded
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .make(),
          ],
        ),
      ),
    ));
  }
}
