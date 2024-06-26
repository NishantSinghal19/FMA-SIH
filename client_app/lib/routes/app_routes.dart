// ignore_for_file: unused_import

import 'package:client_app/presentation/login_page/login_page.dart';
import 'package:client_app/presentation/login_page/login_page_2.dart';
import 'package:client_app/presentation/map_location_bottomsheet/map_2.dart';
import 'package:client_app/presentation/mine_page/mine_page.dart';
import 'package:client_app/presentation/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:client_app/presentation/splash_screen/splash_screen.dart';
import 'package:client_app/presentation/login_page_tab_container_screen/login_page_tab_container_screen.dart';
import 'package:client_app/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:client_app/presentation/verify_otp_screen/verify_otp_screen.dart';
import 'package:client_app/presentation/country_or_region_screen/country_or_region_screen.dart';
import 'package:client_app/presentation/mine_page_container_screen/mine_page_container_screen.dart';
import 'package:client_app/presentation/transfer_screen/transfer_screen.dart';
import 'package:client_app/presentation/send_money_screen/send_money_screen.dart';
import 'package:client_app/presentation/currency_exchange_screen/currency_exchange_screen.dart';
import 'package:client_app/presentation/transfer_amount_screen/transfer_amount_screen.dart';
import 'package:client_app/presentation/confirmation_screen/confirmation_screen.dart';
import 'package:client_app/presentation/transfer_request_screen/transfer_request_screen.dart';
import 'package:client_app/presentation/history_screen/history_screen.dart';
import 'package:client_app/presentation/atm_location_screen/atm_location_screen.dart';
import 'package:client_app/presentation/profile_screen/profile_screen.dart';
import 'package:client_app/presentation/settings_screen/settings_screen.dart';
import 'package:client_app/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginPage = '/login_page';

  static const String loginPageTabContainerScreen =
      '/login_page_tab_container_screen';

  static const String signUpPage = '/sign_up_page';
  

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String verifyOtpScreen = '/verify_otp_screen';

  static const String countryOrRegionScreen = '/country_or_region_screen';

  static const String minePage = '/mine_page';

  static const String minePageContainerScreen = '/mine_page_container_screen';

  static const String transferScreen = '/transfer_screen';

  static const String sendMoneyScreen = '/send_money_screen';

  static const String statisticsPage = '/statistics_page';

  static const String statisticsTabContainerPage =
      '/statistics_tab_container_page';

  static const String currencyExchangeScreen = '/currency_exchange_screen';

  static const String transferAmountScreen = '/transfer_amount_screen';

  static const String confirmationScreen = '/confirmation_screen';

  static const String transferRequestScreen = '/transfer_request_screen';

  static const String historyScreen = '/history_screen';

  static const String nationalBankPage = '/national_bank_page';

  static const String atmLocationScreen = '/atm_location_screen';

  static const String profileScreen = '/profile_screen';

  static const String settingsScreen = '/settings_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String mapLocationBottomSheet = '/map_location_bottom_sheet';
  
  static const String drainagePage = '/drainafe_page';
  
  static const String communtiyPage= '/community_page';

  

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    loginPageTabContainerScreen: (context) => LoginPageTabContainerScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    verifyOtpScreen: (context) => VerifyOtpScreen(),
    countryOrRegionScreen: (context) => CountryOrRegionScreen(),
    minePageContainerScreen: (context) => MinePageContainerScreen(),
    transferScreen: (context) => TransferScreen(),
    sendMoneyScreen: (context) => SendMoneyScreen(),
    currencyExchangeScreen: (context) => CurrencyExchangeScreen(),
    transferAmountScreen: (context) => TransferAmountScreen(),
    confirmationScreen: (context) => ConfirmationScreen(),
    transferRequestScreen: (context) => TransferRequestScreen(),
    historyScreen: (context) => HistoryScreen(),
    atmLocationScreen: (context) => AtmLocationScreen(),
    profileScreen: (context) => ProfileScreen(),
    settingsScreen: (context) => SettingsScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    loginPage: (context) => LoginScreen2(),
    signUpPage: (context) => SignUpPage(),
    mapLocationBottomSheet: (context) => MapScreen(),
    drainagePage: (context) => MinePage(),
    communtiyPage: (context) => TransferAmountScreen(),
  };
}
