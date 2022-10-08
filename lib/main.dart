import 'package:deptech_test/core/model/admin_model.dart';
import 'package:deptech_test/core/utils/storage/local_database_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import 'core/utils/navigation/navigation_utils.dart';
import 'global_providers.dart';
import 'injector.dart';
import 'ui/constant/constant.dart';
import 'ui/constant/themes.dart';
import 'ui/router/route_list.dart';
import 'ui/router/router_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup injector
  await setupLocator();

  /// Registering global providers
  List<SingleChildWidget> providers = await GlobalProviders.register();

  final dbHelper = LocalDatabaseUtils.instance;

  /// Insert Data Admin
  var count = await dbHelper.queryRowCountAdmin();
  if (count == null || count == 0) {
    await dbHelper.insertDataAdmin(
      AdminModel(
        firstName: "Resa",
        lastName: "Suhendra",
        email: "resa@gmail.com",
        password: "qwqw1234",
        birthDate: "07-10-2000",
        gender: "L",
        profileImage: '',
      ).toJson(),
      LocalDatabaseUtils.tableAdmin,
    );
  }

  runApp(MyApp(
    providers: providers,
  ));
}

class MyApp extends StatefulWidget {
  final List<SingleChildWidget> providers;

  const MyApp({Key? key, required this.providers}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      navigatorKey: locator<NavigationUtils>().navigatorKey,
      theme: lightTheme,
      themeMode: ThemeMode.dark,
      builder: (ctx, child) {
        setupScreenUtil(ctx);
        return MediaQuery(
          data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          ),
        );
      },
      initialRoute: routeSplash,
      onGenerateRoute: RouterGenerator.generate,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
