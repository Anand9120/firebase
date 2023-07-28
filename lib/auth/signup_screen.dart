


import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading=false;
  final _formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passController=TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sign Up')),

      ),
      body: Container(
        width:double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              tileMode: TileMode.mirror,
                transform: GradientRotation(50),
                colors:[
                  Color(0xff33ccff),
                  Color(0xffff99cc)


                ]

            ),
            borderRadius: BorderRadius.circular(12)
        ),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(controller:emailController,decoration: const InputDecoration(
                        hintText: 'Email',prefixIcon: Icon(Icons.alternate_email),


                      ),keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Email';
                          }
                          return null;
                        },),
                      const SizedBox(height: 10,),

                      TextFormField(controller: passController,obscureText: true,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_lock),
                          hintText: 'Password',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),


                    ],
                  )
              ),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (

                  )
                  {

                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading=true;
                  });
_auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString()).then((value){
  setState(() {
    loading=false;
  });
  

}).onError((error, stackTrace) {
  Util().toastMessage(error.toString());
  setState(() {
    loading=false;
  });
});
                }

              }, child: loading?const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): const Text(
                'Sign Up',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white),)),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(" Have an account ?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

                  }, child: const Text('Login'))

                ],
              )



            ],
          ),
        ),
      ),




    );
  }
}
