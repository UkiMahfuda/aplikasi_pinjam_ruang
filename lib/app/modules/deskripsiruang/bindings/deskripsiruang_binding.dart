import 'package:get/get.dart';

import '../controllers/deskripsiruang_controller.dart';

class DeskripsiruangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeskripsiruangController>(
      () => DeskripsiruangController(),
    );
  }
}
