import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: "Enter Your Email"),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: "Enter Your Password"),
          ),
          ElevatedButton(
              onPressed: () async {
                String message = '';
                if (_formKey.currentState!.validate()) {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    Future.delayed(const Duration(seconds: 3), () {
                      print('success');
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (_) => HomePage()),
                      );
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                      message = 'Invalid login credentials.';
                    } else {
                      message = e.code;
                    }
                    Fluttertoast.showToast(
                      msg: message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  }
                }
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}
