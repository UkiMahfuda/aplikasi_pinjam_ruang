import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

Color _backgroundColor = Colors.indigo.shade50;

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Pinjam Ruang | UTI',
      home: Scaffold(
        backgroundColor: _backgroundColor,
        body: ListView(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: Image.network('https://i.ibb.co/k34YnYr/uti.png'),
                  ),
                  Text(
                    'Universitas Teknokrat Indonesia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                transform: Matrix4.translationValues(0.0, -75.0, 0.0),
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 25, left: 25, right: 25, bottom: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Login Account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 35,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextField(
                                        controller: controller.cEmail,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          hintText: "Email",
                                          labelText: "Email",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        obscureText: true,
                                        controller: controller.cPass,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          hintText: "Password",
                                          labelText: "Password",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Reset Password",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      TextButton(
                                        onPressed: () => cAuth.login(
                                            controller.cEmail.text,
                                            controller.cPass.text),
                                        child: Text("LOGIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          fixedSize: Size(double.infinity, 40),
                                          minimumSize:
                                              Size(double.infinity, 50),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account?",
                          style: TextStyle(color: Colors.black38, fontSize: 13),
                        ),
                        SizedBox(width: 5),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.SIGNUP),
                          child: Text("Sign Up"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
