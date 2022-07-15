import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Container(
              color: Theme.of(context).primaryColorDark,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                        elevation: 8,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(children: <Widget>[
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            TextField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  onPressed: () => print('login clicked'),
                                  child: Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                      minimumSize: Size(double.infinity, 36)),
                                )),
                          ]),
                        ))
                  ]))),
    );
  }
}
