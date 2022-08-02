import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addrecord extends StatefulWidget {
  const addrecord({Key? key}) : super(key: key);

  @override
  State<addrecord> createState() => _addrecordState();
}

final curuser = FirebaseAuth.instance.currentUser!;
var currentUserId = curuser.uid;

class _addrecordState extends State<addrecord> {
  final namecontroller = TextEditingController();
  final detailcontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final quantitycontroller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new User")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Product Name",

                  //labelText: "User name",
                ),
              ),
              TextFormField(
                controller: detailcontroller,
                decoration: InputDecoration(
                  labelText: "Product Detail",

                  //labelText: "User name",
                ),
              ),
              TextFormField(
                controller: quantitycontroller,
                decoration: InputDecoration(
                  labelText: "Product Quantity",

                  //labelText: "User name",
                ),
              ),
              TextFormField(
                controller: pricecontroller,
                decoration: InputDecoration(
                  labelText: "Product Price",

                  //labelText: "User name",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.blueAccent,
                  onPressed: () {
                    final user = User(
                      name: namecontroller.text,
                      detail: detailcontroller.text,
                      quantity: quantitycontroller.text,
                      price: pricecontroller.text,
                      curUser: currentUserId,
                    );
                    createUser(user: user);
                    Navigator.pop(context);
                  },
                  child: Text("ADD Order"))
            ],
          ),
        ),
      ),
    );
  }

  Future createUser({required User user}) async {
    final docuser = FirebaseFirestore.instance.collection('Product').doc();
    user.id = docuser.id;
    final json = user.toJson();
    await docuser.set(json);
  }
}

class User {
  String id;
  final String name;
  final String detail;
  final String quantity;
  final String price;
  final String curUser;

  User(
      {this.id = '',
      this.curUser = '{currentUserId}',
      required this.name,
      required this.detail,
      required this.quantity,
      required this.price});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'detail': detail,
        'quantity': quantity,
        'price': price,
        'userId': curUser
      };
}
