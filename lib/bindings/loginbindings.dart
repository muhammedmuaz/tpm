import 'package:get/get.dart';
import 'package:tpm/controller/logincontroller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
