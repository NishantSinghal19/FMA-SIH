import 'package:client_app/widgets/app_bar/custom_app_bar.dart';
import 'package:client_app/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/widgets/custom_button.dart';
import 'package:client_app/widgets/custom_drop_down.dart';
import 'package:client_app/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:client_app/services/signup_service.dart';

// ignore_for_file: must_be_immutable
class FloodSosScreen extends StatefulWidget {
  @override
  _FloodSosScreenState createState() => _FloodSosScreenState();
}

class _FloodSosScreenState extends State<FloodSosScreen>
    with AutomaticKeepAliveClientMixin<FloodSosScreen> {
  TextEditingController languageController = TextEditingController();

  TextEditingController emailOneController = TextEditingController();

  TextEditingController frame212Controller = TextEditingController();

  TextEditingController frame213Controller = TextEditingController();

  TextEditingController frame214Controller = TextEditingController();

  var passwordVisible = false, confirmPasswordVisible = false;

  var signupModel = {
    "name": "",
    "email": "",
    "phone": "",
    "password": "",
    "confirmPassword": "",
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

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
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
                      Text(
                        "Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsMedium16,
                      ),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        controller: languageController,
                        hintText: "Dmitry Ponomarev ",
                        margin: getMargin(
                          left: 1,
                        ),
                        suffix: Container(
                          margin:
                              getMargin(left: 30, top: 4, bottom: 4, right: 13),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCheckmarkIndigoA100,
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: getVerticalSize(
                            27,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 22,
                        ),
                        child: Text(
                          "Email",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16,
                        ),
                      ),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        controller: emailOneController,
                        hintText: "xyz@gmail.com",
                        margin: getMargin(
                          left: 1,
                          top: 1,
                        ),
                        textInputType: TextInputType.emailAddress,
                      ),
                      Container(
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
                                "Phone",
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
                              controller: frame212Controller,
                              hintText: "+1-123-456-7890",
                              alignment: Alignment.bottomCenter,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 24,
                        ),
                        child: Text(
                          "Password",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16,
                        ),
                      ),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        controller: frame213Controller,
                        hintText: "xyz123",
                        isObscureText: passwordVisible,
                        margin: getMargin(
                          top: 1,
                        ),
                        suffix: IconButton(
                          icon: CustomImageView(
                            svgPath: ImageConstant.imgEye,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: getVerticalSize(
                            26,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 23,
                        ),
                        child: Text(
                          "Confirm Password",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16,
                        ),
                      ),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        controller: frame214Controller,
                        hintText: "xyz123",
                        isObscureText: confirmPasswordVisible,
                        margin: getMargin(
                          top: 1,
                        ),
                        textInputAction: TextInputAction.done,
                        suffix: IconButton(
                          icon: CustomImageView(
                            svgPath: ImageConstant.imgEye,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                confirmPasswordVisible =
                                    !confirmPasswordVisible;
                              },
                            );
                          },
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: getVerticalSize(
                            26,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: getPadding(
                      //     top: 23,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         height: getVerticalSize(
                      //           52,
                      //         ),
                      //         width: getHorizontalSize(
                      //           155,
                      //         ),
                      //         child: Stack(
                      //           alignment: Alignment.topLeft,
                      //           children: [
                      //             CustomDropDown(
                      //               width: getHorizontalSize(
                      //                 153,
                      //               ),
                      //               focusNode: FocusNode(),
                      //               icon: Container(
                      //                 margin: getMargin(
                      //                   left: 30,
                      //                   right: 10,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                     color: ColorConstant.black900,
                      //                     width: getHorizontalSize(
                      //                       1,
                      //                     ),
                      //                     strokeAlign: strokeAlignCenter,
                      //                   ),
                      //                 ),
                      //                 child: CustomImageView(
                      //                   svgPath:
                      //                       ImageConstant.imgArrowdownBlack900,
                      //                 ),
                      //               ),
                      //               hintText: "20 - Jan - 1998",
                      //               variant:
                      //                   DropDownVariant.UnderLineBluegray100,
                      //               fontStyle: DropDownFontStyle
                      //                   .PoppinsRegular14Black900,
                      //               alignment: Alignment.bottomCenter,
                      //               items: dropdownItemList,
                      //               onChanged: (value) {},
                      //             ),
                      //             Align(
                      //               alignment: Alignment.topLeft,
                      //               child: Text(
                      //                 "Date Of Birth",
                      //                 overflow: TextOverflow.ellipsis,
                      //                 textAlign: TextAlign.left,
                      //                 style: AppStyle.txtPoppinsMedium16,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Country/Region",
                      //             overflow: TextOverflow.ellipsis,
                      //             textAlign: TextAlign.left,
                      //             style: AppStyle.txtPoppinsMedium16,
                      //           ),
                      //           CustomDropDown(
                      //             width: getHorizontalSize(
                      //               145,
                      //             ),
                      //             focusNode: FocusNode(),
                      //             icon: Container(
                      //               margin: getMargin(
                      //                 left: 30,
                      //               ),
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                   color: ColorConstant.black900,
                      //                   width: getHorizontalSize(
                      //                     1,
                      //                   ),
                      //                   strokeAlign: strokeAlignCenter,
                      //                 ),
                      //               ),
                      //               child: CustomImageView(
                      //                 svgPath:
                      //                     ImageConstant.imgArrowdownBlack900,
                      //               ),
                      //             ),
                      //             hintText: "United States",
                      //             variant: DropDownVariant.None,
                      //             fontStyle: DropDownFontStyle
                      //                 .PoppinsRegular14Black900,
                      //             items: dropdownItemList1,
                      //             onChanged: (value) {},
                      //           ),
                      //           Padding(
                      //             padding: getPadding(
                      //               top: 6,
                      //             ),
                      //             child: SizedBox(
                      //               width: getHorizontalSize(
                      //                 155,
                      //               ),
                      //               child: Divider(
                      //                 height: getVerticalSize(
                      //                   1,
                      //                 ),
                      //                 thickness: getVerticalSize(
                      //                   1,
                      //                 ),
                      //                 color: ColorConstant.blueGray100,
                      //                 indent: getHorizontalSize(
                      //                   1,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      CustomButton(
                        height: getVerticalSize(
                          50,
                        ),
                        text: "Create Account",
                        margin: getMargin(
                          top: 53,
                        ),
                        shape: ButtonShape.RoundedBorder13,
                        onTap: () {
                          signupModel["name"] = languageController.text;
                          signupModel["email"] = emailOneController.text;
                          signupModel["phone"] = frame212Controller.text;
                          signupModel["password"] = frame213Controller.text;
                          signupModel["confirmPassword"] =
                              frame214Controller.text;

                          if (signupModel["name"]!.isEmpty) {
                            showToast("Please enter name");
                            return;
                          }
                          if (signupModel["email"]!.isEmpty) {
                            showToast("Please enter email");
                            return;
                          }
                          if (signupModel["phone"]!.isEmpty ||
                              signupModel["phone"]!.length != 10) {
                            showToast(
                                "Please enter phone number with 10 digits");
                            return;
                          }
                          if (signupModel["password"]!.isEmpty) {
                            showToast("Please enter password");
                            return;
                          }
                          if (signupModel["confirmPassword"]!.isEmpty) {
                            showToast("Please enter confirm password");
                            return;
                          }
                          if (signupModel["password"] !=
                              signupModel["confirmPassword"]) {
                            showToast(
                                "Password and confirm password does not match");
                            return;
                          }
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 13,
                            top: 25,
                            right: 13,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsMedium16Bluegray400,
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 0,
                                ),
                                child: TextButton(
                                    child: Text("Sign In",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsSemiBold16),
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              AppRoutes.loginPage));
                                    }),
                              ),
                            ],
                          ),
                        ),
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
