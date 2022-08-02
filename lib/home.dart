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

  Widget buildUser(User1 user) => Card(
      elevation: 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('4.5'),
            ),
            title: Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.detail),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text("Quantity:"),
              Text(user.quantity),
              SizedBox(
                width: 20,
              ),
              Text("Price:"),
              Text(user.price)
            ],
          )
        ],
      )
      // ListTile(
      //   leading: CircleAvatar(
      //     child: Text('${user.age}'),
      //   ),
      //   title: Text(user.name),
      //   subtitle: Text(user.designation),
      // ),
      );

  Stream<List<User1>> readUsers() => FirebaseFirestore.instance
      .collection('Product')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User1.fromJson(doc.data())).toList());
}

class User1 {
  String id;
  final String name;
  final String detail;
  final String quantity;
  final String price;
  User1(
      {this.id = '',
      required this.name,
      required this.detail,
      required this.quantity,
      required this.price});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'detail': detail,
        'quantity': quantity,
        'price': price
      };

  static User1 fromJson(Map<String, dynamic> json) => User1(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      quantity: json['quantity'],
      price: json['price']);
}
