import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),)
              ,
              ElevatedButton(onPressed: (){
                auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                  Util().toastMessage('We have send you mail to reset password please check');
                }).onError((error, stackTrace)  {
                  Util().toastMessage(error.toString());
                });

              }, child: Text('Change'))

            ],
          ),
        ),
      ),
    );
  }
}
