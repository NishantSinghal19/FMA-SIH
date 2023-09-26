import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:client_app/widgets/app_bar/custom_app_bar.dart';

var alertsList = [
  {'name': 'Marlee Rice', 'location': 'Noida, Uttar Pradesh', 'priority': 'high'},
  {'name': 'Jason Roy', 'location': 'Shahdara, Delhi', 'priority': 'medium'},
  {'name': 'Ritu Singh', 'location': 'Chandini Chowk, Delhi', 'priority': 'low'},
];

var priorityMapping = {
  'high': Color.fromARGB(255, 207, 42, 30),
  'medium': Color.fromARGB(255, 255, 238, 81),
  'low': Color.fromARGB(255, 23, 171, 28),
};

class CommunityScreen extends StatefulWidget {
  CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(49),
                leadingWidth: 59,
                centerTitle: true,
                title: AppbarSubtitle(text: "Community Page")),
            body: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: alertsList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Container(),
                itemBuilder: (BuildContext context, int index) {
                  final alertData = alertsList[index];
                  return Container(
                    margin: getMargin(left: 25, top: 25, right: 25),
                    padding:
                        getPadding(left: 10, top: 10, right: 10, bottom: 10),
                    decoration: AppDecoration.txtOutlineGray300.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder13),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: getPadding(top: 1),
                            child: Row(children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgEllipse31140x401,
                                  height: getSize(40),
                                  width: getSize(40),
                                  radius: BorderRadius.circular(
                                      getHorizontalSize(20)),
                                  margin: getMargin(left: 14)),
                              Padding(
                                  padding:
                                      getPadding(left: 14, top: 1, bottom: 2),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(alertData['name'] as String,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsMedium14Black900),
                                      ])),
                              Spacer(),
                              Icon(
                                Icons.circle_rounded,
                                color: priorityMapping[alertData['priority']]!,
                                size: getSize(18),
                              )
                            ])),
                        Padding(
                            padding: getPadding(top: 10, bottom: 10),
                            child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.gray200)),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: ColorConstant.indigoA100,
                                  size: getSize(19)),
                              Padding(
                                padding: getPadding(top: 1, left: 3),
                                child: Text(
                                  alertData['location'] as String,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ColorConstant.indigoA100,
                                      fontSize: getFontSize(14),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
            ));
  }

  onTapSendmoney(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.confirmationScreen);
  }

  onTapArrowleft4(BuildContext context) {
    Navigator.pop(context);
  }
}
