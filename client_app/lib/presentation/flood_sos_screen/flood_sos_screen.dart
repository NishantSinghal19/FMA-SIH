import 'dart:io';

import 'package:client_app/widgets/app_bar/custom_app_bar.dart';
import 'package:client_app/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/widgets/custom_button.dart';
import 'package:client_app/widgets/custom_drop_down.dart';
import 'package:client_app/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:client_app/services/signup_service.dart';
import 'package:image_picker/image_picker.dart';

// ignore_for_file: must_be_immutable
class FloodSosScreen extends StatefulWidget {
  @override
  _FloodSosScreenState createState() => _FloodSosScreenState();
}

class _FloodSosScreenState extends State<FloodSosScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  var sosModel = {
    "name": "",
    "phone": "",
    "password": "",
  };

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT, //duration
        gravity: ToastGravity.BOTTOM, //location
        timeInSecForIosWeb: 1,
        backgroundColor:
            const Color.fromARGB(255, 255, 143, 135), //background color
        textColor: Colors.white, //text Color
        fontSize: 16.0 //font size
        );
  }

  void imageUploadAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(120, 60),
                        backgroundColor: ColorConstant.indigoA100,
                        elevation: 3),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(120, 60),
                        backgroundColor: ColorConstant.indigoA100,
                        elevation: 3),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    bool isForYourself = args["isForYourself"];

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 24,
                    right: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomIconButton(
                          height: 35,
                          width: 35,
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            onTapBtnArrowleft(context);
                          },
                          child: CustomImageView(
                              svgPath: ImageConstant.imgArrowleftBlack900)),
                      Padding(padding: getPadding(bottom: 40)),
                      !isForYourself
                          ? Text(
                              "Name of the person in need",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium16,
                            )
                          : Container(),
                      !isForYourself
                          ? CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: nameController,
                              hintText: "Dmitry Ponomarev",
                              margin: getMargin(
                                left: 1,
                              ),
                              suffix: Container(
                                margin: getMargin(
                                    left: 30, top: 4, bottom: 4, right: 13),
                                child: CustomImageView(
                                  svgPath: ImageConstant.imgCheckmarkIndigoA100,
                                ),
                              ),
                              suffixConstraints: BoxConstraints(
                                maxHeight: getVerticalSize(
                                  27,
                                ),
                              ),
                            )
                          : Container(),
                      !isForYourself
                          ? Container(
                              height: getVerticalSize(
                                51,
                              ),
                              width: getHorizontalSize(
                                327,
                              ),
                              margin: getMargin(
                                top: 24,
                              ),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Phone Number of the person in need",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsMedium16,
                                    ),
                                  ),
                                  CustomTextFormField(
                                    width: getHorizontalSize(
                                      326,
                                    ),
                                    focusNode: FocusNode(),
                                    controller: phoneController,
                                    hintText: "+91-9876543210",
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: getPadding(
                          top: 24,
                        ),
                        child: Text(
                          "Upload Flood Images",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(120, 60),
                            backgroundColor: ColorConstant.indigoA100,
                            elevation: 3),
                        onPressed: () {
                          imageUploadAlert();
                        },
                        child: Text('Upload'),
                      ),
                      image != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                ),
                              ),
                            )
                          : Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            ),
                      CustomButton(
                        height: getVerticalSize(
                          50,
                        ),
                        text: "Raise SOS",
                        margin: getMargin(
                          top: 53,
                        ),
                        shape: ButtonShape.RoundedBorder13,
                        onTap: () {
                          sosModel["name"] = nameController.text;
                          sosModel["phone"] = phoneController.text;
                          // sosModel["password"] = imageController.text;

                          if (sosModel["name"]!.isEmpty) {
                            showToast("Please enter name");
                            return;
                          }
                          if (sosModel["phone"]!.isEmpty ||
                              sosModel["phone"]!.length != 10) {
                            showToast(
                                "Please enter phone number with 10 digits");
                            return;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

onTapBtnArrowleft(BuildContext context) {
  Navigator.pop(context);
}
