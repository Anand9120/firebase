import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({super.key});

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {
 final fireStore=FirebaseFirestore.instance.collection('users');
  final postController=TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add FireStore Data'),

      ),
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(

          children: [
            const SizedBox(height: 30),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: 'What is in your mind'
                  ,border: OutlineInputBorder()
              ),



            )
            ,const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){


              setState(() {
                loading=true;
              });
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              fireStore.doc(id).set({'title': postController.text.toString(),'id':id

              }).then((value) {
                Util().toastMessage('Post added');
                setState(() {
                  loading=false;
                });

              }).onError((error, stackTrace) {
                Util().toastMessage(error.toString());
                setState(() {
                  loading=false;
                });
              })
              ;
            }, child: const Text('Add'))
          ],
        ),
      ),
    );
  }

}
