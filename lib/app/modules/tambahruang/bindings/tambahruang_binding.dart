import 'package:get/get.dart';

import '../controllers/tambahruang_controller.dart';

class TambahruangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahRuangController>(
      () => TambahRuangController(),
    );
  }
}
