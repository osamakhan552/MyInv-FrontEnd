import 'package:flutter/material.dart';
import 'package:wppl/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import '../components/constant.dart';
import '../util/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  late String valueText;
  late String codeDialog;
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (LoginController cntrl) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            // executes after build
            switch (cntrl.role) {
              case Roles.admin:
                Get.offNamed("/admin");
                break;
              default:
                print(Get.currentRoute);
                // Get.clearRouteTree();
                if (Get.currentRoute != "/") Get.offNamed("/");
            }
          });
          return showLoginScreen(context, cntrl);
        });
  }

  void logIn() {
    //CircularProgressIndicator;
    Get.find<LoginController>().logIn();
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Forgot Password?'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  print("1");
                  valueText = value;
                });
              },
              controller: textFieldController,
              decoration: InputDecoration(hintText: "Enter your username"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    forgotPassword(codeDialog);
                  });
                },
              ),
            ],
          );
        });
  }

  Scaffold showLoginScreen(BuildContext context, LoginController cntrl) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 2,
                  color: kPrimaryColor,
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2,
                    color: Colors.white),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'b.png',
                      height: 400,
                      width: 400,
                      scale: 2.5,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (widget, animation) =>
                  ScaleTransition(child: widget, scale: animation),
              child: Padding(
                padding: EdgeInsets.all(size.height > 770
                    ? 64
                    : size.height > 670
                        ? 32
                        : 16),
                child: Center(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: size.height *
                          (size.height > 770
                              ? 0.7
                              : size.height > 670
                                  ? 0.8
                                  : 0.9),
                      width: 500,
                      color: Colors.white,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "LOG IN",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 30,
                                  child: Divider(
                                    color: kPrimaryColor,
                                    thickness: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextField(
                                    controller: cntrl.usernameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Username",
                                        prefixIcon: Icon(Icons.person))),
                                SizedBox(
                                  height: 32,
                                ),
                                TextField(
                                    controller: cntrl.passwordController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Password",
                                        prefixIcon: Icon(Icons.password),
                                        suffixIcon: IconButton(
                                          icon: cntrl.obscurePassword
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                          onPressed:
                                              cntrl.changePasswordVisibility,
                                        )),
                                    obscureText: cntrl.obscurePassword),
                                SizedBox(
                                  height: 64,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    shadowColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      logIn();
                                    });
                                  },
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "LogIn",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.white),
                                        ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
