import 'dart:io';

import 'package:client_app/core/models/drainage_complaint_model.dart';
import 'package:client_app/widgets/app_bar/appbar_subtitle.dart';
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
class DrainageScreen extends StatefulWidget {
  @override
  _DrainageScreenState createState() => _DrainageScreenState();
}

class _DrainageScreenState extends State<DrainageScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<XFile> imageArray = [];
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      if (img != null && imageArray.length < 3) imageArray.add(img);
    });
  }

  late DrainageComplaintModel complaintModel;

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
    return SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Scaffold(
            // backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
                height: getVerticalSize(49),
                leadingWidth: 59,
                centerTitle: true,
                title: AppbarSubtitle(text: "Help Portal for Water Problems")),
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
                              Text(
                                "Name",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsMedium16,
                              ),
                              CustomTextFormField(
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
                                    svgPath:
                                        ImageConstant.imgCheckmarkIndigoA100,
                                  ),
                                ),
                                suffixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(
                                    27,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: getPadding(top: 24),
                                child: Text(
                                  "Phone Number",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium16,
                                ),
                              ),
                              CustomTextFormField(
                                margin: getMargin(
                                  left: 1,
                                ),
                                focusNode: FocusNode(),
                                controller: phoneController,
                                hintText: "+91-9876543210",
                                alignment: Alignment.bottomCenter,
                                suffix: Container(
                                  margin: getMargin(
                                      left: 30, top: 4, bottom: 4, right: 13),
                                  child: CustomImageView(
                                    svgPath:
                                        ImageConstant.imgCheckmarkIndigoA100,
                                  ),
                                ),
                                suffixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(
                                    27,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(top: 24),
                                child: Text(
                                  "Location",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium16,
                                ),
                              ),
                              CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: locationController,
                                hintText: "Select Location",
                                margin: getMargin(
                                  left: 1,
                                ),
                                suffix: Container(
                                  margin: getMargin(
                                      left: 30, top: 4, bottom: 4, right: 13),
                                  child: Icon(
                                    Icons.location_on,
                                    color: ColorConstant.indigoA100,
                                  ),
                                ),
                                suffixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(
                                    27,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(top: 24),
                                child: Text(
                                  "Brief Description of the Problem",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium16,
                                ),
                              ),
                              CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: descriptionController,
                                hintText: "Drainage is blocked",
                                margin: getMargin(
                                  left: 1,
                                ),
                                suffix: Container(
                                  margin: getMargin(
                                      left: 30, top: 4, bottom: 4, right: 13),
                                  child: CustomImageView(
                                    svgPath:
                                        ImageConstant.imgCheckmarkIndigoA100,
                                  ),
                                ),
                                suffixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(
                                    27,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(top: 24),
                                child: Text(
                                  "Image Proof (Max 3)",
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                                    color: Color.fromARGB(
                                                            255, 255, 0, 0)
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
                                text: "File Complaint",
                                margin: getMargin(
                                  top: 30,
                                ),
                                shape: ButtonShape.RoundedBorder13,
                                onTap: () {
                                  complaintModel.name = nameController.text;
                                  complaintModel.phone = phoneController.text;
                                  complaintModel.location = {
                                    "latitude": locationController.text,
                                    "longitude": locationController.text,
                                  };
                                  complaintModel.description =
                                      descriptionController.text;
                                  complaintModel.images = imageArray;

                                  if (complaintModel.name.isEmpty ||
                                      complaintModel.name.length == 0 ||
                                      complaintModel.description.isEmpty ||
                                      complaintModel.description.isEmpty ||
                                      complaintModel.phone.isEmpty ||
                                      complaintModel.phone.isEmpty) {
                                    showToast("Please enter all fields");
                                    return;
                                  }
                                  if (complaintModel.phone.length != 10) {
                                    showToast(
                                        "Please enter phone number with 10 digits");
                                    return;
                                  }
                                },
                              ),
                            ],
                          ))
                    ])))));
  }
}

onTapBtnArrowleft(BuildContext context) {
  Navigator.pop(context);
}
