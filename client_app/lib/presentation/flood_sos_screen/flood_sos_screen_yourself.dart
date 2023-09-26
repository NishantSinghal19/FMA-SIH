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
class FloodSosScreenYourself extends StatefulWidget {
  @override
  _FloodSosScreenState createState() => _FloodSosScreenState();
}

class _FloodSosScreenState extends State<FloodSosScreenYourself> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<XFile> imageArray = [];
  final ImagePicker picker = ImagePicker();
  bool isForYourself = true;

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      if (img != null && imageArray.length < 3) imageArray.add(img);
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
                        minimumSize: Size(100, 50),
                        backgroundColor: ColorConstant.indigoA100,
                        elevation: 3),
                  ),
                  SizedBox(
                    height: 10,
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
                        minimumSize: Size(100, 50),
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
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    // bool isForYourself = args["isForYourself"] == "true" ? true : false;

    return SafeArea(
      minimum: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                      Padding(padding: getPadding(bottom: 10)),
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
                                    margin: getMargin(
                                      left: 1,
                                      top: 3,
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
                        padding: getPadding(top: 24),
                        child: Text(
                          "Upload Flood Images (Max 3)",
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
                            minimumSize: Size(90, 30),
                            backgroundColor: imageArray.length < 3
                                ? ColorConstant.indigoA100
                                : ColorConstant.gray200,
                            elevation: 3),
                        onPressed: () {
                          if (imageArray.length < 3) imageUploadAlert();
                        },
                        child: Text('Upload'),
                      ),
                      imageArray.isNotEmpty
                          ? ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: imageArray.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemBuilder: (BuildContext context, int index) {
                                final imageData = imageArray[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            File(imageData.path),
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          )),
                                      Positioned(
                                        right: -2,
                                        top: 25,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color:
                                                Color.fromARGB(255, 255, 0, 0)
                                                    .withOpacity(0.7),
                                            size: 22,
                                          ),
                                          onPressed: () => setState(() {
                                            imageArray.removeAt(index);
                                          }),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })
                          : Text(
                              "No Image",
                              style: AppStyle.txtPoppinsMedium11Gray500,
                            ),
                      CustomButton(
                        height: getVerticalSize(
                          50,
                        ),
                        text: "Raise SOS",
                        margin: getMargin(
                          top: 30,
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
