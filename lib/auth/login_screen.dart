



import 'package:firebase/auth/login_with_phone_number.dart';
import 'package:firebase/auth/signup_screen.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _animationController;
  var listRadius=[50.0,70.0,90.0,100.0,110.0];
  @override
  void initState() {

    super.initState();
    _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 10),lowerBound: 0.5);
    _animation=Tween(begin: 0.0,end: 1.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {

      });
    });
    _animationController.forward();

  }
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
  void logIn(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password:passController.text.toString()).then((value) {
      Util().toastMessage(value.user!.email.toString());
      Navigator.push(context,MaterialPageRoute(builder: (context)=>const PostScreen()) );
      setState(() {
        loading=false;
      });

    }).onError((error, stackTrace) {
      debugPrint (error.toString());
      Util().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Login'),
          automaticallyImplyLeading: false,


        ),
        body: Container(

height: double.infinity,
                  width:double.infinity,
          decoration: BoxDecoration(

            gradient: const RadialGradient(
              colors:[
                Color(0xfffad0c4),
                Color(0xffd1f8ff)


              ]

            ),
            borderRadius: BorderRadius.circular(12)
          ),

         child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(


              children: [
                Image.asset(
                  "assets/images/Rectangle 19.png",
                  width: 385,
                  height: 163,
                ),
                const SizedBox(height: 10,),
                Form(
                  key: _formKey,
                    child: Column(
                  children: [
                    TextFormField(controller:emailController,decoration:  InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(49),

                      ),

                      hintText: 'Email',prefixIcon: const Icon(Icons.alternate_email),prefixIconColor: Colors.amber


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
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(49),),
                        prefixIcon: const Icon(Icons.mail_lock),prefixIconColor: Colors.blue.shade700,
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
                 Align(
                  alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordScreen()));

                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Forget Password',style: TextStyle(color: Colors.red),),
                  ),
                ),),

                const SizedBox(height: 10,),
                InkWell( onTap: (

                    ){

if(_formKey.currentState!.validate()){
  logIn();

}

                }, child: Stack(
                    alignment: Alignment.center,
                    children: [buildMyContainer(listRadius[0]),
                    buildMyContainer(listRadius[1]),
                    buildMyContainer(listRadius[2]),
                    buildMyContainer(listRadius[3]),
                    buildMyContainer(listRadius[4]),  loading?const CircularProgressIndicator(strokeWidth: 3,color: Colors.blue,):  const Text(
                  'Login',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.blue),
                )
                    ]
                ),),
                 const SizedBox(height: 15,),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    TextButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                    }, child: const Text('Sign Up'))

                  ],
                ),
                const SizedBox(height: 30,),

                InkWell(
                  onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginWithPhoneNumber()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(50),border: Border.all(
                          color: Colors.black
                        )
                        ),
              child: const Row(children: [
                SizedBox(width: 100,),
                Text('Login With Number'),SizedBox(width: 60,),
                Icon(Icons.mobile_screen_share_outlined)
              ]
                        ),
                  ),
                ),




                )   
              ],
            ),
          ),
        ),




      ),
    );
  }
  Widget buildMyContainer(radius){
    return  Container(
      width: radius*_animation.value,
      height: radius*_animation.value
      ,decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.withOpacity(1.0 -_animation.value)
    ),
    );
  }
}
