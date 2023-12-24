import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/daftarruang/bindings/daftarruang_binding.dart';
import '../modules/daftarruang/views/daftarruang_view.dart';
import '../modules/deskripsiruang/bindings/deskripsiruang_binding.dart';
import '../modules/deskripsiruang/views/deskripsiruang_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.DAFTARRUANG,
      page: () => DaftarruangView(),
      binding: DaftarruangBinding(),
    ),
    GetPage(
      name: _Paths.DESKRIPSIRUANG,
      page: () => DeskripsiruangView(),
      binding: DeskripsiruangBinding(),
    ),
  ];
}
