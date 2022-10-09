import 'package:deptech_test/core/model/admin_model.dart';
import 'package:deptech_test/core/utils/extensions/string_extension.dart';
import 'package:deptech_test/core/utils/navigation/navigation_utils.dart';
import 'package:deptech_test/core/view_model/admin_provider.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:deptech_test/ui/router/route_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: "resa@gmail.com");
  final passwordController = TextEditingController(text: "qwqw1234");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: setWidth(50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: setHeight(30),
                ),
                Text(
                  "Login Admin",
                  style: styleTitle.copyWith(
                    fontSize: setFontSize(100),
                  ),
                ),
                SizedBox(
                  height: setHeight(60),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: styleSubtitle.copyWith(
                              fontSize: setFontSize(50),
                            ),
                          ),
                          SizedBox(
                            height: setHeight(20),
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              } else if (!value.isValidEmail) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(
                                    gapPadding: 0,
                                    borderRadius:
                                        BorderRadius.circular(borderRadius))),
                          ),
                          SizedBox(
                            height: setHeight(100),
                          ),
                          Text(
                            "Password",
                            style: styleSubtitle.copyWith(
                              fontSize: setFontSize(50),
                            ),
                          ),
                          SizedBox(
                            height: setHeight(20),
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: setHeight(100),
                          ),
                          Consumer<AdminProvider>(
                              builder: (context, adminProvider, _) {
                            return TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  adminProvider.setLoadingLogin(true);
                                  AdminModel? data =
                                      await adminProvider.loginAdmin(
                                          emailController.text,
                                          passwordController.text);

                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  if (data != null) {
                                    navigate
                                        .pushToRemoveUntil(routeDashboard);
                                    adminProvider.setLoadingLogin(false);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Login failed, invalid email or password."),
                                      ),
                                    );
                                    adminProvider.setLoadingLogin(false);
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(borderRadius)),
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(50), //
                              ),
                              child: adminProvider.isLoadingLogin
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Login',
                                      style: styleTitle.copyWith(
                                        fontSize: setFontSize(50),
                                        color: Colors.white,
                                      ),
                                    ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
