class FluAppRouter {
  final String import;
  const FluAppRouter({this.import});
}

class FluRouter {
  final String url;
  final String name;
  final List<String> params;
  final String transition;

  /// url 路径  默认lib文件夹为根路径
  ///
  /// name 路由名称  默认当前类名
  ///
  /// params 参数
  ///
  /// transition 路由动画
  const FluRouter({
    this.url,
    this.name,
    this.params,
    this.transition,
  });
}

class FluTransitionType {
  FluTransitionType._();

  static const String fade = 'FluFadeAnimation';
  static const String slide = 'FluSlideAnimation';
}

class RouterInfo {
  final String import;
  final String constant;
  final String className;
  final List<String> params;
  final String url;
  final String name;
  final String transition;

  RouterInfo({
    this.import,
    this.constant,
    this.className,
    this.params,
    this.url,
    this.name,
    this.transition,
  });
}
