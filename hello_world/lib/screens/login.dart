import 'package:flutter/material.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:hello_world/scripts/device.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late String deviceName;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getDeviceName();
  }
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
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: (String? value) {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(()=>errorMessage=''),
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(labelText: 'Password'),
                            validator: (value) {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(()=>errorMessage=''),
                          ),
                          Text(errorMessage, style: const TextStyle(color: Colors.red),),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () =>
                                    submit(),
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
                      ),
                    ))
              ])),
    );
  }

  Future<void> _getDeviceName() async{
    deviceName = await Device.name();
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    final AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);

    if(_formKey.currentState!.validate())
    {
      try{
        await provider.login(
            emailController.text,
            passwordController.text,
            deviceName);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/categories');
      }
      catch(e)
      {

        setState(()
        {
          errorMessage=e.toString();

          print(errorMessage);
        });
      }
    }
  }
}
