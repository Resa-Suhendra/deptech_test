import 'package:deptech_test/core/model/admin/admin_model.dart';
import 'package:deptech_test/core/utils/extensions/string_extension.dart';
import 'package:deptech_test/core/utils/navigation/navigation_utils.dart';
import 'package:deptech_test/core/view_model/admin_provider.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String? _birthDate;
  Gender? _gender = Gender.Male;

  @override
  void initState() {
    var a = Provider.of<AdminProvider>(context, listen: false).adminModel;

    emailController.text = a!.email!;
    passwordController.text = a.password!;
    firstNameController.text = a.firstName!;
    lastNameController.text = a.lastName!;

    _birthDate = a.birthDate;

    if (a.gender! == 'L') {
      _gender = Gender.Male;
    } else {
      _gender = Gender.Female;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Edit Profile",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(60)),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
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
                            borderRadius: BorderRadius.circular(borderRadius))),
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
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(100),
                  ),
                  Text(
                    "First Name",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(50),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  TextFormField(
                    controller: firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(100),
                  ),
                  Text(
                    "Last Name",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(50),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  TextFormField(
                    controller: lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(100),
                  ),
                  Text(
                    "Gender",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(50),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<Gender>(
                            value: Gender.Male,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Male")
                        ],
                      ),
                      Row(
                        children: [
                          Radio<Gender>(
                            value: Gender.Female,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Female")
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setHeight(100),
                  ),
                  Text(
                    "Birth Date",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(50),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      showDatePicker(
                        context: context,
                        initialDate:
                            DateFormat('dd-MM-yyyy').parse(_birthDate!),
                        firstDate: DateTime(1946),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            _birthDate = DateFormat('dd-MM-yyyy').format(value);
                          });
                        }
                      });
                    },
                    // style: TextButton.styleFrom(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(borderRadius)),
                    //   backgroundColor: primaryColor,
                    //   foregroundColor: Colors.white,
                    //   minimumSize: const Size.fromHeight(50), //
                    // ),
                    child: Row(
                      children: [
                        Text(
                          _birthDate!,
                          style: styleTitle.copyWith(
                            fontSize: setFontSize(50),
                            // color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.calendar_month,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: setHeight(100),
                  ),
                  Consumer<AdminProvider>(builder: (context, adminProvider, _) {
                    return TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          AdminModel data = AdminModel(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            gender: _gender == Gender.Female ? 'P' : 'L',
                            birthDate: _birthDate,
                          );
                          var res = await adminProvider.updateProfile(data);

                          await Future.delayed(const Duration(seconds: 2));
                          if (res != null && res > 0) {
                            navigate.pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: primaryColor,
                                content: const Text("Update Success!"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "Login failed, invalid email or password."),
                              ),
                            );
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)),
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: adminProvider.isLoadingLogin
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Save',
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
        ),
      ),
    );
  }
}

enum Gender { Male, Female }
