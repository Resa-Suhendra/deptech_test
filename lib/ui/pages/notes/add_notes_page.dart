import 'package:deptech_test/core/utils/extensions/string_extension.dart';
import 'package:deptech_test/core/view_model/notes_provider.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotesPage extends StatelessWidget {
  AddNotesPage({Key? key}) : super(key: key);


  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Notes",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(60)),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                        Consumer<NotesProvider>(
                            builder: (context, notesProvider, _) {
                              return TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {

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
                                child: Text(
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
    );
  }
}
