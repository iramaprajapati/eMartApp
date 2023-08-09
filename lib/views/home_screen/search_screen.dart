import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widgets_common/common_widgets.dart';

class SearchScreen extends StatelessWidget {
  final String? searchText;
  const SearchScreen({super.key, this.searchText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: searchText!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else {
            var filteredProducts = snapshot.data?.docs
                .where(
                  (element) => element["p_name"]
                      .toString()
                      .toLowerCase()
                      .contains(searchText!.toLowerCase()),
                )
                .toList();
            if (filteredProducts!.isEmpty) {
              return Center(
                child: "No products found !"
                    .text
                    .color(darkFontGrey)
                    .xl
                    .makeCentered(),
              );
            } else {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    mainAxisExtent: 300),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        filteredProducts[index]["p_imgs"][0],
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                      "${filteredProducts[index]["p_name"]}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "${filteredProducts[index]["p_price"]}"
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
                      .shadowMd
                      .margin(const EdgeInsets.all(12.0))
                      .roundedSM
                      .padding(const EdgeInsets.all(12.0))
                      .make()
                      .onTap(() {
                    Get.to(() => ItemDetails(
                          strTitle: "${filteredProducts[index]["p_name"]}",
                          productsData: filteredProducts[index],
                        ));
                  });
                },
              );
            }
          }
        },
      ),
    );
  }
}
