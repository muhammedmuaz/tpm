import 'package:flutter/material.dart';
import '../../controller/logincontroller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var _formKey = GlobalKey<FormState>();
  LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var dynamicHeight = MediaQuery.of(context).size.height;
    var dynamicWidth = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      body: GetBuilder<LoginController>(builder: (logic) {
        return controller.signUpLoader
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SingleChildScrollView(
                    child: Container(
                      height: dynamicHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: dynamicWidth * 0.35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: Container(
                                        height: 37,
                                        width: dynamicWidth * 0.17,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.5),
                                              bottomLeft:
                                                  Radius.circular(16.5)),
                                          color: Color(0xffFB2330),
                                        ),
                                        child: const Text(
                                          "ENG",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      )),
                                      Flexible(
                                          child: Container(
                                        height: 37,
                                        width: dynamicWidth * 0.17,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(16.5),
                                              bottomRight:
                                                  Radius.circular(16.5)),
                                          // color: Color(0xffFB2330),
                                          // color: Colors.blueGrey,
                                        ),
                                        child: const Text(
                                          "اردو",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Welcome Back!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                // SizedBox()
                                const Text(
                                  "Enter your credentials to continue",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: controller.email,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person_2),
                                    // hintText: 'Phone Number',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4)),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4)),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Password",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: controller.password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    // hintText: 'Phone Number',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4)),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4)),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // handle onTap event
                                        if (_formKey.currentState!.validate()) {
                                          if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(
                                                  controller.email.text)) {
                                            controller.loginButtonController
                                                .stop();
                                            Get.snackbar(
                                              'Invalid Email ',
                                              'Kindly Enter a valid Email address',
                                              colorText: Colors.white,
                                            );
                                          } else {
                                            controller.login();
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFB2330),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  "assets/dawlancelogo.png",
                                  height: 50,
                                  width: 120,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
    ));
  }
}
