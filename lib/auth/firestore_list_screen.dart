import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/posts/add_post.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth=FirebaseAuth.instance;
  final editController=TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('users').snapshots();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,centerTitle: true,
        title: const Text('FireStore'),
        actions: [IconButton(onPressed: (){
          auth.signOut().then((value){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

          }).onError((error, stackTrace)
          {
            Util().toastMessage(error.toString());
          });

        }, icon: const Icon(Icons.logout_outlined)),
          const SizedBox(width: 10,)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const AddFireStoreDataScreen()) );
        },child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
       StreamBuilder<QuerySnapshot>(
         stream:fireStore,
           builder:( BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting)
               return CircularProgressIndicator();
             if (snapshot.hasError)
               return Text('Some Error');

             return Expanded(
                 child: ListView.builder(itemCount: snapshot.data!.docs.length,
                     itemBuilder: (context, index) {
                       return ListTile(

                         title: Text(snapshot.data!.docs[index]['title'].toString()),
                       );
                     }
                     )
             );
           }

       )
        ],
      ),
    );
  }
  Future<void> showMyDialog(String title,String id) async{
    editController.text=title;
    return showDialog(
        builder: (BuildContext context){
          return AlertDialog(
            title:Text('Update'),
            content:Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                    hintText: 'Edit'
                ),
              ),
            ) ,
            actions: [ TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);

              },
                  child: Text('Update'))

            ],

          );
        }
        , context: context);
  }
}

