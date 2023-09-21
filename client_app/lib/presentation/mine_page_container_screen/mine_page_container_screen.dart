import 'package:client_app/presentation/flood_sos_screen/flood_sos_screen.dart';
import 'package:client_app/presentation/map_location_bottomsheet/map_2.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';
import 'package:client_app/presentation/mine_page/mine_page.dart';
import 'package:client_app/presentation/national_bank_page/national_bank_page.dart';
import 'package:client_app/presentation/statistics_tab_container_page/statistics_tab_container_page.dart';
import 'package:client_app/widgets/custom_bottom_app_bar.dart';
import 'package:client_app/widgets/custom_floating_button.dart';
import 'package:client_app/services/localstorage_service.dart';

// ignore_for_file: must_be_immutable
class MinePageContainerScreen extends StatefulWidget {
  MinePageContainerScreen({Key? key}) : super(key: key);

  @override
  _MinePageContainerScreenState createState() =>
      _MinePageContainerScreenState();
}

class _MinePageContainerScreenState extends State<MinePageContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    getIsLoggedIn().then((isLoggedIn) { 
      _isLoggedIn = isLoggedIn ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.mapLocationBottomSheet,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(milliseconds: 20))),
            bottomNavigationBar:
                CustomBottomAppBar(onChanged: (BottomBarEnum type) {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, getCurrentRoute(type, _isLoggedIn));
            }),
            // floatingActionButton: CustomFloatingButton(
            //     height: 50,
            //     width: 50,
            //     child: CustomImageView(
            //         svgPath: ImageConstant.imgQrcodeWhiteA700,
            //         height: getVerticalSize(25.0),
            //         width: getHorizontalSize(25.0))),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked
                ));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type, bool isLoggedIn) {
    switch (type) {
      case BottomBarEnum.Lock:
        return AppRoutes.mapLocationBottomSheet;
      case BottomBarEnum.Checkmarkgray500:
        return AppRoutes.drainagePage;
      case BottomBarEnum.Computergray500:
        return AppRoutes.communtiyPage;
      case BottomBarEnum.Searchgray5002:
        return isLoggedIn ? AppRoutes.profileScreen : AppRoutes.loginPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.drainagePage:
        return MinePage();
      case AppRoutes.communtiyPage:
        return StatisticsTabContainerPage();
      case AppRoutes.mapLocationBottomSheet:
        return MapScreen();
      case AppRoutes.floodSosScreen:
        return FloodSosScreen();
      default:
        return DefaultWidget();
    }
  }
}
