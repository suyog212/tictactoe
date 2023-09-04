import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/auth/multiplayer_login.dart';
import 'package:tic_tac/auth/sign_in_provider.dart';
import 'package:tic_tac/screens/game.dart';
import 'package:tic_tac/screens/multiplayer_game.dart';
import 'package:tic_tac/screens/req_friend.dart';

class GameMode extends StatefulWidget {
  const GameMode({Key? key}) : super(key: key);

  @override
  State<GameMode> createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  final instance = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select GameMode"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            provider.logOut();
          }, icon: const Icon(Icons.logout),tooltip: "Log Out",)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome"),
            Text(instance!.displayName.toString() ?? " "),
            Text(instance!.uid.toString() ?? " "),
            // Text("${instance!.providerData}"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AuthState()));
                },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
                child: const Text("Online"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const GameScreen()));
                },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
                child: const Text("Offline"),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Request()));
            }, child: const Text("Users"))
          ],
        ),
      ),
    );
  }
}
