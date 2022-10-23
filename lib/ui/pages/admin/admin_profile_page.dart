import 'dart:convert';
import 'dart:io';

import 'package:deptech_test/core/utils/navigation/navigation_utils.dart';
import 'package:deptech_test/core/utils/storage/local_storage_utils.dart';
import 'package:deptech_test/core/view_model/admin_provider.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:deptech_test/ui/router/route_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).getAdminData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Profile",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(60)),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<AdminProvider>(builder: (context, adminProvider, _) {
            if (adminProvider.adminModel != null) {
              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                    // height: deviceHeight / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: const Text("First Name"),
                          subtitle: Text(adminProvider.adminModel!.firstName!),
                        ),
                        ListTile(
                          title: const Text("Last Name"),
                          subtitle: Text(adminProvider.adminModel!.lastName!),
                        ),
                        ListTile(
                          title: const Text("Email"),
                          subtitle: Text(adminProvider.adminModel!.email!),
                        ),
                        ListTile(
                          title: const Text("Birth Date"),
                          subtitle: Text(adminProvider.adminModel!.birthDate!),
                        ),
                        ListTile(
                          title: const Text("Gender"),
                          subtitle: Text(
                              adminProvider.adminModel!.gender! == 'L'
                                  ? 'Male'
                                  : 'Female'),
                        ),
                        TextButton(
                          onPressed: () {
                            navigate.pushTo(routeEditProfile);
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
                            "Edit Profile",
                            style: styleTitle.copyWith(
                              fontSize: setFontSize(50),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 110,
                      width: 110,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                image: adminProvider.adminModel!.profileImage !=
                                            null &&
                                        adminProvider.adminModel!.profileImage!
                                            .isNotEmpty
                                    ? DecorationImage(
                                        image: FileImage(File(adminProvider
                                            .adminModel!.profileImage!)))
                                    : null,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: primaryColor)
                                // image: DecorationImage(image: )
                                ),
                          ),
                          Positioned(
                            top: 80,
                            left: 40,
                            child: InkWell(
                              onTap: () async {
                                _pickedImage = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                if (_pickedImage != null) {
                                  adminProvider
                                      .setImageProfile(_pickedImage!.path);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                localStorageUtil.logout();
                navigate.pushToRemoveUntil(routeSplash);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
                backgroundColor: Colors.white,
                foregroundColor: primaryColor,
                minimumSize: const Size.fromHeight(50), //
              ),
              child: Text(
                "Logout",
                style: styleTitle.copyWith(
                  fontSize: setFontSize(50),
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
