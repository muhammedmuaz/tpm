import 'package:get/get.dart';
import 'package:tpm/view/home.dart';
import 'package:tpm/view/tags/createtag.dart';
import 'package:tpm/view/tags/tagraised.dart';
import '../bindings/loginbindings.dart';
import '../bindings/tagcreatebindings.dart';
import '../network/api.dart';
import '../view/auth/login.dart';
import '../view/visualize/visualizeScreen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var initial =
      // Routes.tagraised
      // ;
      Api().sp.read('token') != null ? Routes.home : Routes.login;
  static final routes = [
    // GetPage(name: _Paths.splash, page: () => SplashScreen()),
    GetPage(
        name: _Paths.login,
        page: () => LoginScreen(),
        binding: LoginBindings()),
    GetPage(name: _Paths.home, page: () => HomePage(), binding: TagBindings()),

    GetPage(
        name: _Paths.tags,
        page: () => const TagRaisedScreen(),
        binding: TagBindings()),

    GetPage(
        name: _Paths.home,
        page: () => const TagRaisedScreen(),
        binding: TagBindings()),

    GetPage(
        name: _Paths.tagraised,
        page: () => const TagCreateScreen(),
        binding: TagBindings()),

    GetPage(
        name: _Paths.visualize,
        page: () => VisualizeScreen(),
        binding: TagBindings()),
  ];
}
