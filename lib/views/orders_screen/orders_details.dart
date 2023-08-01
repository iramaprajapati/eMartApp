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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
        ),
      ),
    );
  }
}
