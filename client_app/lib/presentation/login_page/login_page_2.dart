import 'package:client_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/widgets/custom_button.dart';
import 'package:client_app/widgets/custom_icon_button.dart';
import 'package:client_app/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore_for_file: must_be_immutable
class LoginScreen2 extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(top: 50, left: 24, right: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath:
                              ImageConstant.imgIllustrationBlueGray900212x212,
                          height: getSize(212),
                          width: getSize(212),
                          alignment: Alignment.center),
                      Padding(
                          padding: getPadding(top: 40),
                          child: Text("Login",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium30)),
                      Container(
                          width: getHorizontalSize(245),
                          margin: getMargin(left: 41, top: 10, right: 41),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Please enter your ",
                                    style: TextStyle(
                                        color: ColorConstant.blueGray400,
                                        fontSize: getFontSize(14),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text: "phone number.",
                                    style: TextStyle(
                                        color: ColorConstant.indigoA100,
                                        fontSize: getFontSize(14),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500))
                              ]),
                              textAlign: TextAlign.center)),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        controller: phoneController,
                        hintText: "981xxxxxxx",
                        margin: getMargin(top: 25),
                        variant: TextFormFieldVariant.OutlineBluegray100,
                        shape: TextFormFieldShape.RoundedBorder13,
                        padding: TextFormFieldPadding.PaddingAll12,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                      ),
                      CustomButton(
                          height: getVerticalSize(50),
                          text: "Send OTP",
                          margin: getMargin(top: 20, bottom: 5),
                          shape: ButtonShape.RoundedBorder13,
                          onTap: () {
                            // TO BE UNCOMMENTED AT THE END
                            // if(phoneController.text.length != 10) {
                            //   showToast("Please enter valid phone number");
                            //   return;
                            // }
                            onTapSendOtp(context, phoneController.text);
                          })
                    ]))));
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT, //duration
        gravity: ToastGravity.BOTTOM, //location
        timeInSecForIosWeb: 2,
        backgroundColor:Colors.red, //background color
        textColor: Colors.white, //text Color
        fontSize: 16.0 //font size
        );
  }

  onTapBtnArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

  onTapSendOtp(BuildContext context, String phone) async {
    Navigator.pushNamed(context, AppRoutes.verifyOtpScreen, arguments: {'phone': phone});
  }
}
