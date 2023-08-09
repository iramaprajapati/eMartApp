import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/chat_screen/messages_screen.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_cart.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/common_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUserProfile(currentUser!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var userProfileData = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    // Profile edit button section
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          size: 30,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        profileController.nameController.text =
                            userProfileData["name"];
                        Get.to(() => EditProfileScreen(
                            userProfileData: userProfileData));
                      }),
                    ),

                    // User profile details section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          userProfileData["profileImgUrl"] == ""
                              ? Image.asset(
                                  imgProfile3,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  userProfileData["profileImgUrl"],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${userProfileData["name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${userProfileData["email"]}".text.white.make(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: whiteColor,
                                ),
                              ),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signOutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: logout.text
                                  .fontFamily(semibold)
                                  .color(whiteColor)
                                  .make())
                        ],
                      ),
                    ),
                    10.heightBox,
                    FutureBuilder(
                      future: FirestoreServices.getAllCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  productCount: countData[0].toString(),
                                  cardTitle: "In your cart",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  productCount: countData[1].toString(),
                                  cardTitle: "In your wishlist",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  productCount: countData[2].toString(),
                                  cardTitle: "In your orders",
                                  width: context.screenWidth / 3.4),
                            ],
                          );
                        }
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     detailsCard(
                    //         productCount: userProfileData["cart_count"],
                    //         cardTitle: "In your cart",
                    //         width: context.screenWidth / 3.4),
                    //     detailsCard(
                    //         productCount: userProfileData["wishlist_count"],
                    //         cardTitle: "In your wishlist",
                    //         width: context.screenWidth / 3.4),
                    //     detailsCard(
                    //         productCount: userProfileData["order_count"],
                    //         cardTitle: "In your orders",
                    //         width: context.screenWidth / 3.4),
                    //   ],
                    // ),

                    // Profile button Section
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrdersScreen());
                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading:
                              Image.asset(profileButtonsIcon[index], width: 22),
                          title: profileButtonsList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .margin(const EdgeInsets.all(12))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
