import 'package:flutter/material.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:provider/provider.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                      elevation: 8,
                      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(()=>errorMessage=''),
                            decoration: const InputDecoration(labelText: 'Name'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller:emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(()=>errorMessage=''),
                            decoration: const InputDecoration(labelText: 'Email'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller:passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(()=>errorMessage=''),
                            decoration: const InputDecoration(labelText: 'Password'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller:passwordConfirmController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please confirm your password';
                              }

                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(()=>errorMessage=''),
                            decoration:
                                const InputDecoration(labelText: 'Confirm Password'),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () => submit(),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                    minimumSize: const Size(double.infinity, 36)),
                                child: const Text('Register'),
                              )),
                          Text(errorMessage, style: const TextStyle(color: Colors.red)),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () => Navigator.pop(context, '/login'),
                              child: const Text('Back to Login'),
                            ),
                          )
                        ]),
                      ))
                ]),
          )),
    );
  }

  Future<void> submit() async {

    final form = _formKey.currentState;

    final AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      try {
        await provider.register(
            nameController.text,
            emailController.text,
            passwordController.text,
            passwordConfirmController.text,
            'Flutter Device');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        setState(() => errorMessage = e.toString());
      }
    }
  }
}
