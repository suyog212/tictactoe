import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';


final loginuser = FirebaseAuth.instance.currentUser;


class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final storemessages = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Expanded(child: ShowMessages()),
            ElevatedButton.icon(
              onPressed: (){
                storemessages.collection("Users").doc(loginuser!.uid).set({
                  "name" : loginuser!.displayName,
                  "uid": loginuser!.uid,
                  "email": loginuser!.email.toString(),
                  "time": DateTime.now(),
                });
              },
              icon: const Icon(Icons.person_add_alt),
              label: const Text("Add Users to database"),
            )
          ],
        ),
      ),
    );
  }
}


class ShowMessages extends StatelessWidget {
  const ShowMessages({super.key});


  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunchUrlString(link.url)) {
      await launchUrlString(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            reverse: true,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Linkify(
                        text : x["name"].toString(),
                        onOpen: _onOpen,
                      ),
                    )
                  ],
                ),
                subtitle: Column(
                  children: <Widget>[
                    Text(x["uid"]),
                    Text(x["email"]),
                  ],
                ),
                onLongPress: (){
                  if(x['email'] == loginuser!.email){
                    FirebaseFirestore.instance.collection("Users").doc(loginuser!.uid).delete();
                  }
                } ,
              );
            });
      },
    );
  }
}