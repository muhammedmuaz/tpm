import 'package:get/get.dart';
import 'package:tpm/controller/logincontroller.dart';
import 'package:tpm/controller/tagcontroller.dart';

class TagBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TagController>(() => TagController());
  }
}
