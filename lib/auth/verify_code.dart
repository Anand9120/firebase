

import 'dart:math';

import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final phoneNNumberController=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(keyboardType: TextInputType.phone,
              controller:phoneNNumberController,decoration: const InputDecoration(
hintText: '6 digit code'
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: () async {
setState(() {
  loading=true;
});


                  final credential=PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: phoneNNumberController.text.toString()

                  );
                  try{

                    await auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
                  }catch(e){
                    setState(() {
                      loading=false;
                    });

                  }Util().toastMessage(e.toString());

            }, child: const Text('Verify'))
          ],
        ),
      ),
    );
  }
}
