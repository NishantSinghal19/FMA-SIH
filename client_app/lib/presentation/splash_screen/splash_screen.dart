import 'package:flutter/material.dart';
import 'dart:async';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacementNamed(context, AppRoutes.minePageContainerScreen)
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.indigoA100,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: getPadding(
                  right: 5,
                  bottom: 5,
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgVideocamera,
                      height: getVerticalSize(
                        32,
                      ),
                      width: getHorizontalSize(
                        37,
                      ),
                      margin: getMargin(
                        top: 9,
                        bottom: 8,
                        left: 8
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: getPadding(
                          left: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "APLAVYAKULA",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtProximaNovaABold28.copyWith(
                                letterSpacing: getHorizontalSize(
                                  1.82,
                                ),
                              ),
                            ),
                            Text(
                              "we serve with faith".toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium10.copyWith(
                                letterSpacing: getHorizontalSize(
                                  1.6,
                                ),
                              ),
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
    );
  }
}
