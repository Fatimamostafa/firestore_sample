import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {bool replace = false}) {
    if (replace) {
      return navigatorKey.currentState!.pushReplacementNamed(routeName);
    } else {
      return navigatorKey.currentState!.pushNamed(routeName);
    }
  }

  Future<dynamic> navigateToWithArgument(String routeName,
      {dynamic arguments, bool replace = false}) {
    if (replace) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }

  Future<dynamic> navigateToRemoveUntil(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  Future<dynamic> navigateWithFade(Widget screen) {
    return navigatorKey.currentState!.push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return screen;
      },
      transitionsBuilder: (context, animation1, animation2, child) {
        return FadeTransition(
          opacity: animation1,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    ));
  }
}
