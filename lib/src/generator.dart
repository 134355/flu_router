import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'router.dart';
import 'template.dart';
import 'explanation.dart';

class FluRouterGenerator extends GeneratorForAnnotation<FluRouter> {
  static List<RouterInfo> routes = List();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    String url = annotation.peek('url')?.stringValue;
    String name = annotation.peek('name')?.stringValue;
    String transition = annotation.peek('transition')?.stringValue;

    final List<String> params =
        annotation.peek('params')?.listValue?.map((name) {
      return name.toStringValue();
    })?.toList();

    final String className = element.displayName;
    final String path = buildStep.inputId.path;
    final String package = buildStep.inputId.package;
    final String filePath = '${path.replaceFirst('lib/', '')}';
    final String routerPath = filePath.replaceFirst('.dart', '');

    if (url == null) {
      url = '/' + routerPath;
    }

    if (name == null) {
      name = className.toUpperCase();
    }

    if (transition == null) {
      transition = 'FluSlideAnimation';
    }

    final import = 'import \'package:$package/$filePath\';';
    final constant = 'static const String ${name.toUpperCase()} = \'$url\';';

    routes.add(RouterInfo(
      import: import,
      constant: constant,
      className: className,
      params: params,
      url: url,
      name: name,
      transition: transition,
    ));

    return null;
  }
}

class FluAppRouterGenerator extends GeneratorForAnnotation<FluAppRouter> {
  final String explanation = explanationContent;

  List<RouterInfo> getRouterInfoList() {
    return FluRouterGenerator.routes;
  }

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    String imported = annotation.peek('import')?.stringValue;

    if (imported == null) {
      imported = "";
    }

    final className = element.displayName;
    final List<RouterInfo> routerInfoList = getRouterInfoList();

    final Set<String> importContent = Set();
    final Set<String> constContent = Set();
    final Set<String> mapContent = Set();

    routerInfoList.forEach((RouterInfo routerInfo) {
      importContent.add(routerInfo.import);
      constContent.add(routerInfo.constant);
      mapContent.add(handleMap(routerInfo.url, routerInfo.className,
          routerInfo.params, routerInfo.transition));
    });

    return '''
      $explanation
      import 'package:flutter/material.dart';
      import 'package:flu_router/flu_router.dart';
      import 'package:flu_no/flu_no.dart';
      $imported
      ${importContent.join('\n')}
      class $className {
        $className._();
        ${constContent.join('\n')}

        static final Map<String, RouteFactory> _appRouterMap = {
          ${mapContent.join('\n')}
        };

        static RouteFactory onGenerateRoute = (settings) => _appRouterMap[settings.name](settings);

        /// 退出当前页面
        static void pop<T extends Object>([T result]) {
          FluNavigatorObserver.fNavigator.pop(result);
        }

        /// 跳转到新页面
        static Future<T> pushNamed<T extends Object>(String routeName, { Object arguments }) {
          return FluNavigatorObserver.fNavigator.pushNamed<T>(routeName, arguments: arguments);
        }

        /// 从 A->B->C->D 结束后返回 A 页面
        static void popUntil(String routeName) {
          FluNavigatorObserver.fNavigator.popUntil(ModalRoute.withName(routeName));
        }
        
        /// 退出当前页面并跳转到新页面
        static Future<T> popAndPushNamed<T extends Object, TO extends Object>(
          String routeName, {
          TO result,
          Object arguments
        }) {
          return FluNavigatorObserver.fNavigator.popAndPushNamed(routeName, result: result, arguments: arguments);
        }

        /// 替换当前页面
        static Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
          String routeName, {
          TO result,
          Object arguments,
        }) {
          return FluNavigatorObserver.fNavigator.pushReplacementNamed(routeName, result: result, arguments: arguments);
        }

        /// 跳转到指定页面，然后删除所有页面或指定页面
        static Future<T> pushNamedAndRemoveUntil<T extends Object>(
          String newRouteName,
          RoutePredicate predicate, {
          Object arguments,
        }) {
          return FluNavigatorObserver.fNavigator.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
        }
      }''';
  }
}
