import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pr/app/routing/router/app_router.dart';
import 'package:test_pr/app/routing/navigation_util/inavigation_util.dart';
import 'package:test_pr/app/routing/router/routes.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.homeRoute,
      onGenerateRoute: appRouter.onGenerateRoute,
      navigatorKey: context.read<INavigationUtil>().navigatorKey,
    );
  }
}
