import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'generator.dart';

Builder fluRouterBuilder(BuilderOptions options) =>
    LibraryBuilder(FluRouterGenerator(), generatedExtension: '.routes.dart');
Builder fluAppRouterBuilder(BuilderOptions options) =>
    LibraryBuilder(FluAppRouterGenerator(), generatedExtension: '.router.dart');
