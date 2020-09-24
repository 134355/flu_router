import 'package:flutter/material.dart';
import 'package:flu_router/flu_router.dart';
import 'router.router.dart';

@FluRouter(params: ['title'])
class Home extends StatelessWidget {
  final String title;
  const Home({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Text(title),
          Text('home页面'),
          InkWell(
            child: Text('hello'),
            onTap: () {
              FluAppRoutes.pop('hello');
            },
          ),
          InkWell(
            child: Text('world'),
            onTap: () {
              FluAppRoutes.pop('world');
            },
          )
        ],
      ),
    );
  }
}
