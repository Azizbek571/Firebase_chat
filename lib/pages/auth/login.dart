import 'package:firebasewithteacher/components/button.dart';
import 'package:firebasewithteacher/components/input.dart';
import 'package:firebasewithteacher/stores/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Center(
                  child: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 25),
                      child: controller.loading
                          ? const CircularProgressIndicator()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat,
                                    size: 80, color: Colors.grey.shade800),
                                const SizedBox(height: 16),
                                const Text(
                                  "Welcome! Enter the system",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                Input(
                                    controller: controller.email,
                                    hintText: "Log in",
                                    obscureText: false),
                                const SizedBox(height: 16),
                                Input(
                                    controller: controller.password,
                                    hintText: "Password",
                                    obscureText: true),
                                const SizedBox(height: 16),
                                Button(onTap: (){
                                  controller.login_();
                                }, text: "Log in"),
                                const SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [const Text("No Accaunt?"),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: widget.onTap,
                                  child: const Text("Register",
                                  style: TextStyle(fontWeight: FontWeight.w700),)
                                )
                                  
                                  ],)

                              ],
                            )))),
        );
      },
    );
  }
}
