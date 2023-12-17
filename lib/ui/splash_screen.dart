import 'package:flutter/material.dart';
import 'package:restaurant_v2/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MainPage();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: const ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  child: Image(
                    image: AssetImage("assets/imgs/splash_image.jpg"),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
                child: Text(
              "Restaurant",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          ],
        ));
  }
}
