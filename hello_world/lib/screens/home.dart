import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Go to login'),
          onPressed: () => Navigator.pushNamed(context, '/login'),
        ),
      ),
    );
  }
}