import 'package:firebase/auth/verify_code.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNNumberController=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(keyboardType: TextInputType.phone,
              controller:phoneNNumberController,decoration: const InputDecoration(
hintText: '+91 1234567891'
            ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              setState(() {
                loading =true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNNumberController.text,
                  verificationCompleted: (_){
setState(() {
  loading=false;
});
                  },
                  verificationFailed: (e){
                  Util().toastMessage(e.toString());
                  },
                  codeSent:(String verificationId,int? token){
Navigator.push(context,MaterialPageRoute(builder: (context)=>VerifyCodeScreen(verificationId: verificationId,)));
setState(() {
  loading=false;
});
                  },
                  codeAutoRetrievalTimeout: (e){
                  Util().toastMessage(e.toString());
                  setState(() {
                    loading=false;
                  });
                  });
            }, child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
