import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _name = TextEditingController();
  // final TextEditingController _name = TextEditingController();
  // final TextEditingController _name = TextEditingController();
  // final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "ex. Pablo Escobar",
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.email),
                      // suffixIcon: _myIcon,
                      iconColor: Colors.green,
                      suffixIconColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.purple, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 2)),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.purple, width: 2),
                      ),
                      // errorText: "Error",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.purple, width: 2),
                      )),
                  controller: _name,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
