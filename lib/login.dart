import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/main.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _isObscure = true;
  bool value = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    hintText: "Email", suffixIcon: Icon(Icons.done)

                    //labelText: "User name",
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                    child: Checkbox(
                        value: this.value,
                        onChanged: (bool) {
                          setState(() {
                            this.value = !value;
                          });
                        })),
                Text("I agree to "),
                Text(
                  " Privacy Policy",
                  style: TextStyle(color: Colors.blue),
                ),
                Text(" and "),
                Text(
                  " Term and Condition ",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.910,
            height: MediaQuery.of(context).size.height * 0.060,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: signIn,
                child: Text(
                  "Log in",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 36, 179, 110),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Text(
                "Forget Password?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("Login with social account"),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.410,
                  height: MediaQuery.of(context).size.height * 0.070,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                        child: Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                      Text("Facebook",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              //gmail button
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.410,
                  height: MediaQuery.of(context).size.height * 0.070,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                      Text("Gmail",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 179, 110),
                    border:
                        Border.all(color: Color.fromARGB(255, 36, 179, 110)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Don't have an account?"),
            InkWell(
              onTap: () => {Navigator.pushNamed(context, '/signup')},
              child: Text(
                " Sign up",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ])
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
