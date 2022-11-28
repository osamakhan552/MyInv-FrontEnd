import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wppl/src/controllers/login_controller.dart';

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
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "logo.png",
                      height: 75,
                    )),
                SelectableText(
                  "Login",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SelectableText(
                  "Sign in to your account",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                TextField(
                    controller: cntrl.usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person))),
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
                          onPressed: cntrl.changePasswordVisibility,
                        )),
                    obscureText: cntrl.obscurePassword),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  // onPressed: () {
                  //   return logIn();
                  // },

                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(const Duration(seconds: 3), () {
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
                          "Log In",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),

                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle:
                        const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  //onPressed: () => forgotPassword(cntrl.usernameController.text),

                  child: Text(
                    'Forgot Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),

                  onPressed: () {
                    print("clicked on forgot password");
                    showAlertDialog(context);
                  },
                ),
                SelectableText("Dont have an account? Sign up")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
