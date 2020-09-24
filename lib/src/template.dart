String handleArgs(params) {
  if (params.isEmpty) {
    return '';
  } else {
    final StringBuffer buffer = StringBuffer();
    params.forEach((name) {
      buffer.write("$name : arguments['$name'],");
    });
    return buffer.toString();
  }
}

String handleMap(url, widget, params, transition) {
  if (params == null) {
    return '''
    '$url': (RouteSettings settings) => $transition($widget()),''';
  } else {
    String param = handleArgs(params);
    return '''
    '$url': (RouteSettings settings) {
      final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
      return $transition($widget($param));
    },
    ''';
  }
}
