import 'package:flutter/material.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:hello_world/providers/category_provider.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/screens/login.dart';
import 'package:hello_world/screens/register.dart';
import 'package:hello_world/screens/categories.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: ((context, value, child) {
        
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryProvider>(
              create: (context) => CategoryProvider()),
          ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider()),
        ],
        child: MaterialApp(
            title: 'Categories App',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            routes: {
              '/': (context) {
                final authProvider = Provider.of<AuthProvider>(context);
                if(authProvider.isAuthenticated){
                  return const Home();
                }
                else{
                  return const Login();
                }
              },
              '/login': (context) => const Login(),
              '/register': (context) => const Register(),
              '/categories': (context) => const Categories(),
            }),
      );
      }))
    );
  }
}
