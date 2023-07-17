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
                      height: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //if userProfileData["profileImgUrl"] is not empty but profileController.profileImgPath is empty
                  : userProfileData["profileImgUrl"] != "" &&
                          profileController.profileImgPath.isEmpty
                      ? Image.network(
                          userProfileData["profileImgUrl"],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      //if both are empty
                      : Image.file(
                          File(profileController.profileImgPath.value),
                          width: 100,
                          height: 100,
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
              10.heightBox,
              customTextField(
                  title: oldpass,
                  hint: passwordHint,
                  controller: profileController.oldPasswordController,
                  isPassTextField: true),
              10.heightBox,
              customTextField(
                  title: newpass,
                  hint: passwordHint,
                  controller: profileController.newPasswordController,
                  isPassTextField: true),
              20.heightBox,
              profileController.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          btnTitle: "Update",
                          btnTextColor: whiteColor,
                          btnBgColor: redColor,
                          btnOnPressed: () async {
                            profileController.isLoading(true);

                            // if profile image is not selected
                            if (profileController
                                .profileImgPath.value.isNotEmpty) {
                              await profileController.uploadProfileImage();
                            } else {
                              profileController.profileImgLink =
                                  userProfileData["profileImgUrl"];
                            }

                            // if old password matches firebase database password.
                            if (userProfileData["password"] ==
                                profileController.oldPasswordController.text) {
                              // to update user login password
                              await profileController.changeAuthPassword(
                                  email: userProfileData["email"],
                                  oldPassword: profileController
                                      .oldPasswordController.text,
                                  newPassword: profileController
                                      .newPasswordController.text);

                              await profileController.updateProfile(
                                name: profileController.nameController.text,
                                password: profileController
                                    .newPasswordController.text,
                                imgUrl: profileController.profileImgLink,
                              );
                              VxToast.show(context,
                                  msg: "Updated successfully!");
                            } else {
                              VxToast.show(context, msg: "Wrong old password.");
                              profileController.isLoading(false);
                            }
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
