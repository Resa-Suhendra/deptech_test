import 'package:deptech_test/ui/pages/admin/edit_profile_page.dart';
import 'package:deptech_test/ui/pages/dashboard/dashboard_page.dart';
import 'package:deptech_test/ui/pages/login/login_page.dart';
import 'package:deptech_test/ui/pages/notes/add_notes_page.dart';
import 'package:deptech_test/ui/pages/notes/edit_notes_page.dart';
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

      /// Admin group
      case routeEditProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfilePage(),
          settings: const RouteSettings(name: routeEditProfile),
        );

      /// Admin group
      case routeEditProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfilePage(),
          settings: const RouteSettings(name: routeEditProfile),
        );

      /// Notes group
      case routeAddNotes:
        return MaterialPageRoute(
          builder: (_) => const AddNotesPage(),
          settings: const RouteSettings(name: routeAddNotes),
        );

      case routeEditNotes:
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => EditNotesPage(id: args),
            settings: const RouteSettings(name: routeAddNotes),
          );
        }
        break;
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
