import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_class/components/login_signup_btn.dart';
import 'package:firebase_auth_class/components/utils.dart';
import 'package:firebase_auth_class/pages/login_page.dart';
import 'package:firebase_auth_class/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetEmail() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Utils.showSnackBar('Password Reset Link Has Been Sent To Your Email');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    Navigator.pop(context);
    // print('Success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.home,
                size: 60,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter your email to reset password!',
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cant be empty';
                    }
                    return null;
                  },
                  controller: emailController,
                  style:
                      TextStyle(fontSize: 12, height: 1.0, color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade500)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginButton(
                  onTap: () {
                    resetEmail();
                  },
                  btnTxt: 'Reset Password'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Back To ', style: TextStyle(color: Colors.grey[800])),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
