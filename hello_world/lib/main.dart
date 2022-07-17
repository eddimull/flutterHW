import 'package:flutter/material.dart';
import 'package:hello_world/providers/category_provider.dart';
import 'package:hello_world/screens/login.dart';
import 'package:hello_world/screens/register.dart';
import 'package:hello_world/screens/categories.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: const Login(),
          routes: {
            '/login': (context) => const Login(),
            '/register': (context) => const Register(),
            '/categories': (context) => const Categories(),
          }),
    );
  }
}
