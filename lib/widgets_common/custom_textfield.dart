import 'package:emart_app/consts/consts.dart';

Widget customTextField(
    {String? title, String? hint, controller, bool isPassTextField = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Using velocity_x here
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPassTextField,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
