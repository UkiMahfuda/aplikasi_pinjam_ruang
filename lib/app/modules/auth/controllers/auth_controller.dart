import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void signup(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
          title: "Verifikasi email",
          middleText:
              "Kami telah mengirimkan verfikasi ke email $emailAddress.",
          onConfirm: () {
            Get.back(); //close dialog
            Get.back(); //login
          },
          textConfirm: "OK");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        //untuk routing
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Verifikasi email",
          middleText: "Harap verifikasi email terlebih dahulu",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword() {}
}
