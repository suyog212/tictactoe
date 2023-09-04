import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/screens/notification_test.dart';
import 'package:tic_tac/utils/theme_colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text("Dark Mode"),
            trailing: ToggleButton(),
          ),
          ListTile(
            title: Text("About Me"),
            onTap: (){
              showDialog(context: context, builder: (BuildContext context) => Container(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    height: 350,
                    width: 300,
                    child:  const Center(
                      child: Text("",style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none
                      ),),
                    ),
                  ),
                ),
              ),
              );
            },
          ),
          ListTile(
            title: Text("Notification test"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NotificationControl()));
            },
          ),
        ],
      ),
    );
  }
}

