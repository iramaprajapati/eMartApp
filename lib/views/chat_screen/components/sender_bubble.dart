import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data["created_on"] == null ? DateTime.now() : data["created_on"].toDate();

  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection:
        data["uid"] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: data["uid"] == currentUser!.uid
          ? const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          : const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                //bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data["msg"]}".text.white.size(16).make(),
          2.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}
