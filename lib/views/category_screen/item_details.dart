import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? strTitle;
  final dynamic productsData;
  const ItemDetails({super.key, required this.strTitle, this.productsData});

  @override
  Widget build(BuildContext context) {
    // ProductController productController = Get.find(); // Get.find() is used to find already initialized controller.
    ProductController productController = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        productController.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                productController.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: strTitle!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (productController.isFav.value) {
                    productController.removeFromWishlist(
                        productsData.id, context);
                  } else {
                    productController.addToWishlist(productsData.id, context);
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color:
                      productController.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Swiper Section
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: productsData["p_imgs"].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            productsData["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                      10.heightBox,
                      // Title and Details Section
                      strTitle!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      // Rating Section
                      VxRating(
                        value: double.parse(productsData["p_rating"]),
                        isSelectable: false,
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${productsData["p_price"]}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                                5.heightBox,
                                "${productsData["p_seller"]}"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => const ChatScreen(), arguments: [
                              productsData["p_seller"],
                              productsData["vendor_id"]
                            ]);
                          }),
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      // Color Section
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color : "
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    productsData["p_colors"].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(
                                                    productsData["p_colors"]
                                                        [index])
                                                .withOpacity(1.0))
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .make()
                                            .onTap(() {
                                          productController
                                              .changeColorIndex(index);
                                        }),
                                        Visibility(
                                          visible: index ==
                                              productController
                                                  .colorIndex.value,
                                          child: const Icon(Icons.done,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            // Quantity Row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity : "
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          productController.decreaseQuantity();
                                          productController.calculateTotalPrice(
                                              int.parse(
                                                  productsData["p_price"]));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    productController.quantity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          productController.increaseQuantity(
                                              int.parse(
                                                  productsData["p_quantity"]));
                                          productController.calculateTotalPrice(
                                              int.parse(
                                                  productsData["p_price"]));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${productsData["p_quantity"]} available)"
                                        .text
                                        .color(fontGrey)
                                        .make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            // Total Row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total : "
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                                "${productController.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      10.heightBox,
                      // Description Section
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${productsData["p_desc"]}"
                          .text
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      // Buttons Section
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetailButtonsList.length,
                          (index) => ListTile(
                            title: itemDetailButtonsList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      20.heightBox,
                      // Products you may like section
                      productsyoumaylike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      // This widget is copied from home screen featured products section.
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4GB / 512GB"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$600"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(8))
                                      .make()),
                        ),
                      ),
                      // Item Details UI is Completed here..
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                btnBgColor: redColor,
                btnTitle: "Add to Cart",
                btnTextColor: whiteColor,
                btnOnPressed: () {
                  if (productController.quantity.value > 0) {
                    productController.addToCart(
                      color: productsData["p_colors"]
                          [productController.colorIndex.value],
                      context: context,
                      vendorId: productsData["vendor_id"],
                      img: productsData["p_imgs"][0],
                      qty: productController.quantity.value,
                      sellername: productsData["p_seller"],
                      title: productsData["p_name"],
                      totalprice: productController.totalPrice.value,
                    );
                    VxToast.show(context, msg: "Added to Cart");
                  } else {
                    VxToast.show(context,
                        msg: "Minimum 1 quantity is required !");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
