import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wppl/src/util/util.dart';
import 'routes.dart';

///
/// Entry point of app.
/// Here initialise anything and decide which screen to show to the user
///

class MyInv extends StatelessWidget {
  const MyInv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Starting app");
    return FutureBuilder(
        future: initialzeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Center(
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                scrollBehavior: WpplCustomScrollBehavior(),
                initialRoute: "/",
                unknownRoute: pageNotFound,
                getPages: routes,
                title: "My Inventory",
                // theme: ThemeData(
                //     primaryColor: kPrimaryColor,
                //     hoverColor: kPrimaryColor,
                //     focusColor: kPrimaryColor,
                //     backgroundColor: kPrimaryColor,
                //     buttonTheme: ButtonThemeData(
                //         buttonColor: kPrimaryColor, hoverColor: kPrimaryColor)
                // )
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}

class WpplCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
