import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationControl extends StatefulWidget {
  const NotificationControl({Key? key}) : super(key: key);

  @override
  State<NotificationControl> createState() => _NotificationControlState();
}

class _NotificationControlState extends State<NotificationControl> {

  TextEditingController _title = TextEditingController();
  TextEditingController _message = TextEditingController();
  @override
  void shownotification(title,body){
    setState(() {
    });
    flutterLocalNotificationsPlugin.show(0,
      "$title ", "$body",
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',importance: Importance.high,
            enableVibration: true,
          )
      ),
    );
  }
  notify(now,String title,String message){
    if(now != DateTime.now().toString()){
      shownotification(title, message);
    }
    else{
      print("Wait some time for notification");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red,width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          width: MediaQuery.of(context).size.width*0.8,
          height: 50,
          child: TextField(
            controller: _title,
            decoration: const InputDecoration(
              hintText: "Title",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red,width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: TextField(
              controller: _message,
              decoration: const InputDecoration(
                hintText: "Message",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(child: const Text("Notify"),
              onPressed: (){
                notify("4:40 PM",_title.text.trim(),_message.text.trim());
                print("Notified");
              },
            ),
          ),
        ],
      )
    );
  }
}
