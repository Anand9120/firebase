
import 'dart:io';

import 'package:firebase/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
 DatabaseReference databaseRef=FirebaseDatabase.instance.ref('Post');
  File? _image;
  final picker=ImagePicker();
  Future getImageGallery()async{
    final pickerFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickerFile!=null){
        _image=File(pickerFile.path);
      }else{
        print('No Image Picked');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text(
          'Upload Image')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(

              child: InkWell(
                onTap: (){
getImageGallery();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.black38)


                  ),
                  child: _image!=null?  Image.file(_image!.absolute)   : Icon(Icons.image),
                ),
              ),

            ),
            SizedBox(height: 10,),
           ElevatedButton(onPressed: ()async{
             firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('folder'+'1234');
             firebase_storage.UploadTask uploadTask=ref.putFile(_image!.absolute);
             await Future.value(uploadTask);
             var newUrl=ref.getDownloadURL();
             databaseRef.child('1').set({'id':'1212','title':newUrl.toString()});
             Util().toastMessage('Uploaded');
           }, child: Text('Upload', style: TextStyle(color: Colors.green

           )
           )
           )


          ],
        ),
      )
    );
}}
