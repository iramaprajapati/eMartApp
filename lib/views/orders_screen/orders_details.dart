import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders_screen/components/order_place_details.dart';
import 'package:emart_app/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Orders Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Placed",
                  showDone: data["order_placed"]),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data["order_confirmed"]),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.local_shipping_outlined,
                  title: "On Delivery",
                  showDone: data["order_on_delivery"]),
              orderStatus(
                  color: Colors.green[800],
                  icon: Icons.done_all_outlined,
                  title: "Delivered",
                  showDone: data["order_delivered"]),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                    title1: "Order Code",
                    data1: data["order_code"],
                    title2: "Shipping Method",
                    data2: data["shipping_method"],
                  ),
                  orderPlacedDetails(
                    title1: "Order Date",
                    data1: intl.DateFormat("dd-MM-yyyy,")
                        .add_jm()
                        .format(data["order_date"].toDate()),
                    title2: "Payment Method",
                    data2: data["payment_method"],
                  ),
                  orderPlacedDetails(
                    title1: "Payment Status",
                    data1: "Unpaid",
                    title2: "Delivery Status",
                    data2: "Order Placed",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data["order_by_name"]}".text.make(),
                            "${data["order_by_email"]}".text.make(),
                            "${data["order_by_phone"]}".text.make(),
                            "${data["order_by_address"]}".text.make(),
                            "${data["order_by_city"]}".text.make(),
                            "${data["order_by_state"]}".text.make(),
                            "${data["order_by_pincode"]}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data["total_amount"]}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  .box
                  .outerShadowMd
                  .white
                  .padding(const EdgeInsets.all(2.0))
                  .make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16.0)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data["orders"].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                        title1: data["orders"][index]["title"],
                        title2: data["orders"][index]["totalprice"],
                        data1: "x ${data["orders"][index]["qty"]}",
                        data2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data["orders"][index]["color"]),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4.0))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
