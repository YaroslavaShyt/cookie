import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cookie/app/routing/router/app_router.dart';
import 'package:cookie/app/routing/navigation_util/inavigation_util.dart';
import 'package:cookie/app/routing/navigation_util/navigation_util.dart';
import 'package:cookie/app/services/locator/locator.dart';
import 'package:cookie/firebase_options.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initLocator();

  final INavigationUtil navigationUtil = NavigationUtil();
  final AppRouter appRouter = AppRouter();

  runApp(MultiProvider(
      providers: [Provider.value(value: navigationUtil)],
      child: App(appRouter: appRouter,)));
}
