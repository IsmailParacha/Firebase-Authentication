import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OwnData extends StatefulWidget {
  const OwnData({Key? key}) : super(key: key);

  @override
  State<OwnData> createState() => _OwnDataState();
}

class _OwnDataState extends State<OwnData> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final String currentUserId = user.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Own Product"),
      ),
      body: Center(child: Text("$currentUserId")),
    );
  }
}
