import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan informasi tinggi layar
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            // Gambar dengan Border, Shadow, dan Radius
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  'https://i.ibb.co/nMxhy9L/gambarlogin.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  height: screenHeight * 0.3,
                ),
              ),
            ),

            // Judul
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Universitas Teknokrat Indonesia',
                style: TextStyle(
                  fontFamily: 'SakkalR',
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.8
                    ..color =
                        const Color.fromARGB(255, 255, 0, 0), // Warna outline
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                'Peminjaman Ruangan',
                style: TextStyle(
                  fontFamily: 'SakkalR',
                  fontSize: 27,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'SakkalR',
                          fontSize: 27,
                          color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextButton(
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontFamily: 'SakkalR',
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              margin: EdgeInsets.only(right: 35, left: 35),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.cEmail,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: InputBorder.none,
                ),
              ),
            ),

            // Input Password
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              margin: EdgeInsets.only(top: 10, right: 35, left: 35),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.cPass,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: InputBorder.none,
                ),
              ),
            ),

            // Tombol Login
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.only(
                right: 50,
                left: 50,
              ), // Tambahkan margin sesuai kebutuhan
              child: ElevatedButton(
                onPressed: () =>
                    cAuth.login(controller.cEmail.text, controller.cPass.text),
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[700], // Warna latar belakang tombol
                  onPrimary: Colors.white, // Warna teks tombol
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Bentuk sudut tombol
                  ),
                ),
              ),
            ),

            // Tombol Reset Password
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Reset Password",
                    textAlign: TextAlign.left, // Ratakan teks ke kiri
                    style: TextStyle(
                      fontFamily:
                          'SakkalR', // Ganti 'NamaFont' dengan nama font yang diinginkan
                      fontSize: 20, // Sesuaikan ukuran font sesuai kebutuhan
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Image.network(
                    'https://i.ibb.co/KN2CZCQ/uti.png',
                    height: 20, // Sesuaikan ukuran logo kecil sesuai kebutuhan
                  ),
                  SizedBox(height: 5),
                  Text(
                    "© 2023 Create By Pioneers",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
