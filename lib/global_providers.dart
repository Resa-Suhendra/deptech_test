
import 'package:deptech_test/core/view_model/admin_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class GlobalProviders {

  /// Register your provider here
  static Future<List<SingleChildWidget>> register() async => [
    ChangeNotifierProvider(create: (context) => AdminProvider()),
    // ChangeNotifierProvider(create: (context) => FavoriteProvider()),
  ];

}