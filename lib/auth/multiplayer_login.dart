import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac/auth/signIn.dart';
import 'package:tic_tac/screens/game__mode.dart';
import 'package:tic_tac/screens/multiplayer_game.dart';

class AuthState extends StatelessWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return const MultiPlayer();
          }
          else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"),);
          }
          else{
            return const SignIn();
          }
        },
      ),
    );
  }
}