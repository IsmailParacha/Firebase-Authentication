import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/signup.dart';

import 'home.dart';
import 'login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAoNuidhC5Ln49vIZPWZst5HcTByWCLP5U", // Your apiKey
      appId: "com.example.flutter_application_1", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "authenticationinternship", // Your projectId
    ),
  );
  runApp(const Myapp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, Snapshot) {
            if (Snapshot.hasData) {
              return homepage();
            } else if (Snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (Snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else {
              return login();
            }
          },
        ),
        routes: {
          '/login': (context) => login(),
          '/home': (context) => homepage(),
          '/signup': (context) => signup(),
        });
  }
}
