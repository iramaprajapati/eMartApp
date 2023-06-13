import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating a method to change Screen.
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // Using GetX
        // Consider using: "Get.to(() => Page())" instead of "Get.to(Page())".
        Get.to(() => const LoginScreen());
      },
    );
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            // Using velocity_x here
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.fontFamily(semibold).white.make(),
            const Spacer(),
            credits.text.fontFamily(semibold).white.make(),
            30.heightBox,
            // Splash Screen UI is completed here.
          ],
        ),
      ),
    );
  }
}
