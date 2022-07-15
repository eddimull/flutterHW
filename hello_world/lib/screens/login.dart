import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: <Widget>[
                        const TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        const TextField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/categories'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.teal,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  minimumSize: const Size(double.infinity, 36)),
                              child: const Text('Login'),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/register'),
                            child: const Text('Register'),
                          ),
                        )
                      ]),
                    ))
              ])),
    );
  }
}
