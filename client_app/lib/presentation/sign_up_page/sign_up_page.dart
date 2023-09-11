import 'package:client_app/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/widgets/custom_button.dart';
import 'package:client_app/widgets/custom_drop_down.dart';
import 'package:client_app/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with AutomaticKeepAliveClientMixin<SignUpPage> {
  TextEditingController languageController = TextEditingController();

  TextEditingController emailOneController = TextEditingController();

  TextEditingController frame212Controller = TextEditingController();

  TextEditingController frame213Controller = TextEditingController();

  TextEditingController frame214Controller = TextEditingController();

  var passwordVisible = false, confirmPasswordVisible = false;

  // List<String> dropdownItemList = [
  //   "Item One",
  //   "Item Two",
  //   "Item Three",
  // ];

  // List<String> dropdownItemList1 = [
  //   "Item One",
  //   "Item Two",
  //   "Item Three",
  // ];

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
                      Text(
                        "Sign Up",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsMedium30,
                      ),
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
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: ColorConstant.indigoA100,
                          //     width: getHorizontalSize(
                          //       1,
                          //     ),
                          //     strokeAlign: strokeAlignCenter,
                          //   ),
                          // ),
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
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 13,
                            top: 55,
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
                                    onPressed: () => Navigator.popUntil(
                                        context, ModalRoute.withName(AppRoutes.loginPage))),
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
