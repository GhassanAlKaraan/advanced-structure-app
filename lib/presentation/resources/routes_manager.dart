import 'package:advanced_structure_app/presentation/forgot_password/forgot_password.dart';
import 'package:advanced_structure_app/presentation/login/login.dart';
import 'package:advanced_structure_app/presentation/main/main_view.dart';
import 'package:advanced_structure_app/presentation/onboarding/onboarding.dart';
import 'package:advanced_structure_app/presentation/register/register.dart';
import 'package:advanced_structure_app/presentation/resources/strings_manager.dart';
import 'package:advanced_structure_app/presentation/splash/splash.dart';
import 'package:advanced_structure_app/presentation/store_details/store_details.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String mainRoute = '/main';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('${AppStrings.noRouteFound}: ${settings.name}'),
                  ),
                ));
    }
  }
}
