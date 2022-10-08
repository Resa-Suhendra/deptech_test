import 'package:deptech_test/ui/pages/dashboard/dashboard_page.dart';
import 'package:deptech_test/ui/pages/login/login_page.dart';
import 'package:deptech_test/ui/pages/splash/splash_page.dart';
import 'package:deptech_test/ui/router/route_list.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  /// Initializing route
  static Route<dynamic>? generate(RouteSettings settings) {
    /// Declaring argumen route
    final args = settings.arguments;
    switch (settings.name) {

      /// Dashboard group
      case routeDashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
          settings: const RouteSettings(name: routeDashboard),
        );

      /// Splash group
      case routeSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: const RouteSettings(name: routeSplash),
        );

      /// Splash group
      case routeLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: const RouteSettings(name: routeSplash),
        );

      /// Restaurant group
      //   case routeRestaurant:
      //     return MaterialPageRoute(
      //       builder: (_) => const RestaurantScreen(),
      //       settings: const RouteSettings(name: routeRestaurant),
      //     );
      //   case routeRestaurantSearch:
      //     return MaterialPageRoute(
      //       builder: (_) => const RestaurantSearchScreen(),
      //       settings: const RouteSettings(name: routeRestaurantSearch),
      //     );
      //   case routeRestaurantByCities:
      //     if (args is String) {
      //       return MaterialPageRoute(
      //         builder: (_) => ResturantCitiesScreen(
      //           city: args,
      //         ),
      //         settings: const RouteSettings(name: routeRestaurantByCities),
      //       );
      //     }
      //     break;
      //   case routeRestaurantDetail:
      //     if (args is String) {
      //       return MaterialPageRoute(
      //         builder: (_) => RestaurantDetailScreen(
      //           id: args,
      //         ),
      //         settings: const RouteSettings(name: routeRestaurantDetail),
      //       );
      //     }
      //     break;
    }

    return null;
  }
}
