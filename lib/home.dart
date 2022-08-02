import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/OwnData.dart';
import 'package:flutter_application_1/addrecord.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Detail"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OwnData()),
                ),
                child: CircleAvatar(
                  child: Text("P"),
                ),
              ),
            )
          ],
        ),
        body: StreamBuilder<List<User1>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else if (snapshot.hasError) {
                return Text("Something went wrong ${snapshot.error}");
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //     //   Text("HomePage"),
        //     //   MaterialButton(
        //     //     color: Colors.blueGrey,
        //     //     onPressed: () {
        //     //       FirebaseAuth.instance.signOut();
        //     //     },
        //     //     child: const Text('Logout'),
        //     //   )
        //     ],
        //   ),
        // ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addrecord()),
              );
            }));
  }

 