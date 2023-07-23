import 'package:emart_app/consts/consts.dart';

//Custom TextFormField without validation
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
          // errorBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: redColor),
          // ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}

// Custom TextFormField with validation
Widget ourTextBox(
    {String? title,
    String? hint,
    String? invalidInputMsg,
    bool? isAddressBox = false,
    controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Using velocity_x here
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        autofocus: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return invalidEmpty;
          }
          if (isAddressBox == true) {
            return null;
          } else {
            if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              //allow upper and lower case alphabets and space
              return invalidInputMsg;
            } else {
              return null;
            }
          }
        },
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
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}

// Custom pincode TextFormField
Widget pincodeTextBox({String? title, String? hint, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Using velocity_x here
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        maxLength: 6,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return invalidEmpty;
          } else {
            return null;
          }
        },
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
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}

// Custom Email TextFormField
Widget emailTextBox({String? title, String? hint, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Using velocity_x here
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return invalidEmpty;
          }
          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return invalidEmail;
          }
          return null;
        },
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
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}

// Custom Mobile Number TextFormField
Widget mobileTextBox({String? title, String? hint, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Using velocity_x here
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        maxLength: 10,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return invalidEmpty;
          }
          if (!RegExp(r'([5-9]{1}[0-9]{9})').hasMatch(value)) {
            // RegExp(r'^[0-9]{10}$') pattern plain match number with length 10
            // RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$') This pattern allows "+" single sign at first.
            return invalidMobile;
          } else {
            return null;
          }
        },
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
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
