import 'package:emart_app/consts/consts.dart';

Widget ourButton({String? btnTitle, btnOnPressed, btnBgColor, btnTextColor}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBgColor,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: btnOnPressed,
      child: btnTitle!.text.color(btnTextColor).fontFamily(bold).make());
}
