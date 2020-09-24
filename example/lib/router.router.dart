// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FluAppRouterGenerator
// **************************************************************************

// **************************************************************************
// 注意：生成的代码，请勿手动修改
// 如果存在新文件需要更新，建议先执行清除命令：
// flutter packages pub run build_runner clean
// 然后执行下列命令重新生成相应文件：
// flutter packages pub run build_runner build --delete-conflicting-outputs
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flu_router/flu_router.dart';
import 'package:flu_no/flu_no.dart';

import 'package:example/home.dart';

class FluAppRoutes {
  FluAppRoutes._();
  static const String HOME = '/home';

  static final Map<String, RouteFactory> _appRouterMap = {
    '/home': (RouteSettings settings) {
      final Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      return FluSlideAnimation(Home(
        title: arguments['title'],
      ));
    },
  };

  static RouteFactory onGenerateRoute =
      (settings) => _appRouterMap[settings.name](settings);

  /// 退出当前页面
  static void pop<T extends Object>([T result]) {
    FluNavigatorObserver.fNavigator.pop(result);
  }

  /// 跳转到新页面
  static Future<T> pushNamed<T extends Object>(String routeName,
      {Object arguments}) {
    return FluNavigatorObserver.fNavigator
        .pushNamed<T>(routeName, arguments: arguments);
  }

  /// 从 A->B->C->D 结束后返回 A 页面
  static void popUntil(String routeName) {
    FluNavigatorObserver.fNavigator.popUntil(ModalRoute.withName(routeName));
  }

  /// 退出当前页面并跳转到新页面
  static Future<T> popAndPushNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO result,
      Object arguments}) {
    return FluNavigatorObserver.fNavigator
        .popAndPushNamed(routeName, result: result, arguments: arguments);
  }

  /// 替换当前页面
  static Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return FluNavigatorObserver.fNavigator
        .pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  /// 跳转到指定页面，然后删除所有页面或指定页面
  static Future<T> pushNamedAndRemoveUntil<T extends Object>(
    String newRouteName,
    RoutePredicate predicate, {
    Object arguments,
  }) {
    return FluNavigatorObserver.fNavigator
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }
}
