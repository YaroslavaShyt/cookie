import 'package:flutter/material.dart';
import 'package:cookie/app/routing/router/routes.dart';
import 'package:cookie/app/screens/dishes_videos/dishes_videos_factory.dart';
import 'package:cookie/app/screens/error/error_factory.dart';
import 'package:cookie/app/screens/home/home_factory.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => _buildHomeSettings(routeSettings));
      case Routes.videosRoute:
        return MaterialPageRoute(builder: (_) => _buildDishesVideosSettings(routeSettings));
      default:
        return MaterialPageRoute(builder: (_) => _buildErrorSettings(routeSettings));
    }
  }
}

Widget _buildHomeSettings(RouteSettings routeSettings){
  return HomeFactory.build();
}

Widget _buildErrorSettings(RouteSettings routeSettings){
  return ErrorFactory.build();
}

Widget _buildDishesVideosSettings(RouteSettings routeSettings){
  final IDishData dishData = routeSettings.arguments as IDishData;
  return DishesVideosFactory.build(dishData: dishData);
}