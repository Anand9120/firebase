import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/posts/add_post.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth=FirebaseAuth.instance;

  final searchFilter=TextEditingController();
  final ref=FirebaseDatabase.instance.ref('Post');
  final editController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(automaticallyImplyLeading: false,centerTitle: true,
        title: const Text('Post'),
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
Navigator.push(context,MaterialPageRoute(builder: (context)=>const AddPostScreen()) );
        },child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(controller: searchFilter,decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search',
            ),onChanged: (String value){
              setState(() {

              });
            },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(query: ref,defaultChild: const Text('loading'), itemBuilder: (context,snapshot,animation,index) {
              final title = Text(snapshot
                  .child('title')
                  .value
                  .toString());
              if (searchFilter.text.isEmpty) {
                return ListTile(tileColor: Colors.lightGreen,
                    title: Text(snapshot
                        .child('title')
                        .value
                        .toString()),
                    subtitle: Text(snapshot
                        .child('id')
                        .value
                        .toString()),
                  trailing:  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context)=>[
                       PopupMenuItem(
                      value: 1,child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          showMyDialog(title.toString(),snapshot
                              .child('id')
                              .value
                              .toString());
                        },
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                    ),
                       PopupMenuItem(
                        onTap: (){
                          ref.child(snapshot
                              .child('id')
                              .value
                              .toString()).remove();
                        },
                        value: 2,child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      ),
                      )],
                  ),

                );
              } else if(title.toString().contains(searchFilter.text.toLowerCase().toLowerCase())){
                return ListTile(tileColor: Colors.lightGreen,
                    title: Text(snapshot
                        .child('title')
                        .value
                        .toString()),
                    subtitle: Text(snapshot
                        .child('id')
                        .value
                        .toString())

                );
              }
              else{
return Container();
              }
              }
               ),
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
                ref.child(id).update({'title':editController.text.toLowerCase()
              }).then((value){
    Util().toastMessage('post updated');
    }).onError((error, stackTrace) {
                  Util().toastMessage(error.toString());
                });
    },
    child: Text('Update'))

            ],

          );
        }
        , context: context);
  }
}
