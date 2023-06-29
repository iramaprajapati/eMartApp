import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        // Get.to(() => const LoginScreen());

        ///  authStateChanges step is required for going to the Home page after firebase setup.
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.to(() => const LoginScreen());
          } else {
            Get.to(() => const Home());
          }
        });
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
