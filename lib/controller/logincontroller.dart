import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tpm/network/api.dart';
import 'package:tpm/view/home.dart';

import '../Routes/app_pages.dart';

// http://175.107.197.28:8001/api/IssueTag/IssueRaised/df7a27a3-4d90-49ea-ad53-c37d7ea87222?pageIndex=0&pageSize=10

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool signUpLoader = false;
  final RoundedLoadingButtonController loginButtonController =
      RoundedLoadingButtonController();

  login() async {
    signUpLoader = true;
    update();
    var response = await Api().postLogin("${baseUrl}api/Authentication/login",
        email: email.text, password: password.text);
    if (response != null) {
      // print(response['Token']);
      Api().sp.write("email", email.text);
      Api().sp.write("password", password.text);
      Api().sp.write("token", response["Data"]['UserData']['Token']);
      Api().sp.write("userId", response["Data"]['UserData']['Id']);
      signUpLoader = false;
      Get.offAllNamed(Routes.home);
    } else {
      email.clear();
      password.clear();
      signUpLoader = false;
    }
    update();
  }
}
