import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppConstants.mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppConstants.tabletBreakpoint;

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < AppConstants.mobileBreakpoint) {
      return 20.0;
    } else if (width < AppConstants.tabletBreakpoint) {
      return 40.0;
    } else {
      return 64.0;
    }
  }

  static T valueByBreakpoint<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < AppConstants.mobileBreakpoint) {
      return mobile;
    } else if (width < AppConstants.tabletBreakpoint) {
      return tablet ?? mobile;
    } else {
      return desktop;
    }
  }
}

