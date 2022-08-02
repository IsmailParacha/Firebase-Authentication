import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:lottie/lottie.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

class _signupState extends State<signup> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                // child: Lottie.network(
                //     'https://assets4.lottiefiles.com/packages/lf20_pprxh53t.json'),
              ),
              Text(
                "Register",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                child: TextFormField(
                  controller: namecontroller,
                  validator: (value) {
                    if (value != null && value != "") {
                      if (value.length < 6) {
                        return "Username length should be atleast 6";
                      } else {
                        return null;
                      }
                    } else {
                      return "Username cannot be empty";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "UserName",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(width: 3, color: Colors.grey))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                child: TextFormField(
                  controller: emailcontroller,
                  validator: (value) {
                    if (value != null && value != "") {
                      if (!regExp.hasMatch(value)) {
                        return "Email is invalid";
                      } else {
                        return null;
                      }
                    } else {
                      return "Email cannot be empty";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(width: 3, color: Colors.grey))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  validator: (value) {
                    if (value != null) {
                      if (value.length < 6 && value != "") {
                        return "Password length should be atleast 6";
                      } else {
                        return null;
                      }
                    } else {
                      return "Pasword cannot be empty";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/home");
                          },
                          icon: Icon(Icons.visibility)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(width: 3, color: Colors.grey))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                child: TextFormField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                      hintText: "Phone Number",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(width: 3, color: Colors.grey))),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                  child: Container(
                    height: 35.0,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 139, 172, 202),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 7,
                              spreadRadius: 2.0,
                              offset: Offset(0, 3)),
                        ]),
                    width: double.infinity,
                    child: RaisedButton(
                      color: Color.fromARGB(255, 139, 172, 202),
                      onPressed: () {
                        signup();
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I have Already an Account"),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: (() {
                          Navigator.pushNamed(context, '/signup');
                        }),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 7, 189, 255),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Future signup() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
