import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/common_widgets.dart';

class CategoryDetails extends StatefulWidget {
  final String? strTitle;
  const CategoryDetails({super.key, required this.strTitle});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  ProductController productController = Get.find();
  dynamic productMethod;

  switchCategory(strTitle) {
    if (productController.subcat.contains(strTitle)) {
      productMethod = FirestoreServices.getSubCategoryProducts(strTitle);
    } else {
      productMethod = FirestoreServices.getProducts(strTitle);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.strTitle);
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.strTitle!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                    productController.subcat.length,
                    (index) => productController.subcat[index]
                            .toString()
                            .text
                            .softWrap(false)
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .roundedSM
                            .size(140, 60)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make()
                            .onTap(() {
                          switchCategory(
                              productController.subcat[index].toString());
                          setState(() {});
                        })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: "No products found !"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    ),
                  );
                } else {
                  var productsData = snapshot.data!.docs;
                  return Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              mainAxisExtent: 250),
                      itemCount: productsData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              productsData[index]["p_imgs"][0],
                              height: 150,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            "${productsData[index]["p_name"]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${productsData[index]["p_price"]}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .outerShadowSm
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          productController
                              .checkIfFavorite(productsData[index]);
                          Get.to(
                            () => ItemDetails(
                                strTitle: "${productsData[index]["p_name"]}",
                                productsData: productsData[index]),
                          );
                        });
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
