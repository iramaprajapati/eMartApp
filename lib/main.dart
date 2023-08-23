import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To use GetX change this MaterialApp to GetMaterialApp.
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          // To set appBar icons color
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
