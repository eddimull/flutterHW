import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        const TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        const TextField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        const TextField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () => print('login clicked'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.teal,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  minimumSize: const Size(double.infinity, 36)),
                              child: const Text('Register'),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () => Navigator.pop(context, '/login'),
                            child: const Text('Back to Login'),
                          ),
                        )
                      ]),
                    ))
              ])),
    );
  }
}
