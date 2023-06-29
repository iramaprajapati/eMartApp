import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic userProfileData;

  const EditProfileScreen({super.key, this.userProfileData});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // To remove bottom overflow error while typing in text form field.
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if userProfileData["profileImgUrl"] and profileController.profileImgPath is empty
              userProfileData["profileImgUrl"] == "" &&
                      profileController.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile3,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //if userProfileData["profileImgUrl"] is not empty but profileController.profileImgPath is empty
                  : userProfileData["profileImgUrl"] != "" &&
                          profileController.profileImgPath.isEmpty
                      ? Image.network(
                          userProfileData["profileImgUrl"],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      //if both are empty
                      : Image.file(
                          File(profileController.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  btnTitle: "Change",
                  btnTextColor: whiteColor,
                  btnBgColor: redColor,
                  btnOnPressed: () {
                    profileController.changeImage(context);
                  }),
              const Divider(),
              20.heightBox,
              customTextField(
                  title: name,
                  hint: nameHint,
                  controller: profileController.nameController),
              customTextField(
                  title: password,
                  hint: passwordHint,
                  controller: profileController.passwordController,
                  isPassTextField: true),
              20.heightBox,
              profileController.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          btnTitle: "Save",
                          btnTextColor: whiteColor,
                          btnBgColor: redColor,
                          btnOnPressed: () async {
                            profileController.isLoading(true);
                            await profileController.uploadProfileImage();
                            await profileController.updateProfile(
                              name: profileController.nameController.text,
                              password:
                                  profileController.passwordController.text,
                              imgUrl: profileController.profileImgLink,
                            );
                            VxToast.show(context, msg: "Saved successfully!");
                          }),
                    ),
            ],
          )
              .box
              .white
              .padding(const EdgeInsets.all(16))
              //  .margin(const EdgeInsets.only(top: 50))
              .margin(const EdgeInsets.all(16))
              .shadowSm
              .rounded
              .make(),
        ),
      ),
    );
  }
}
