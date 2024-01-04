import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkmandu/screens/signin_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            // Show a loading splash screen while waiting for the authentication state
            return SplashScreen();
          } else if (snapshot.hasData){
            // User is authenticated, navigate to the home page
            return HomePage();
          } else if (snapshot.hasError){
            // Display an error message if there's an issue with authentication
            return Center(child: Text("Error signing in with google"),);
          } else{
            // User is not authenticated, show the sign-in page
            return SignInScreen();
          }
        },
      ),
    );
  }
}
