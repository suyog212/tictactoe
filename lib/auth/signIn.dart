import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/auth/multiplayer_login.dart';
import 'package:tic_tac/auth/sign_in_provider.dart';
import 'package:tic_tac/auth/signup.dart';
import 'package:tic_tac/screens/game__mode.dart';

import '../utils/theme_colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool revPass = true;
  Icon _myIcon = Icon(null);
  String emailError = 'Enter valid email';
  String passError = 'Password length should be at least 8 characters';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email.addListener(_checkEmail);
  }

  _checkEmail() {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email.text);

    if (emailValid)
      setState(() {
        _myIcon = Icon(Icons.check);
      });
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Sign In",
          style: TextStyle(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Container(
                    height: 200,
                  ),
                  SizedBox(
                    // height: 55,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "example@gmail.com",
                          fillColor: Colors.grey,
                          prefixIcon: Icon(Icons.email),
                          suffixIcon: _myIcon,
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
                      validator: (email) {
                        if (email == null ||
                            email.isEmpty &&
                                EmailValidator.validate(email) == false) {
                          return emailError;
                        }
                        return null;
                      },
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // height: 55,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          fillColor: Colors.grey,
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (revPass) {
                                  setState(() {
                                    revPass = false;
                                  });
                                } else {
                                  setState(() {
                                    revPass = true;
                                  });
                                }
                              },
                              icon: revPass
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
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
                      obscureText: revPass,
                      controller: _password,
                      keyboardType: TextInputType.emailAddress,
                      validator: (pass) {
                        var check = pass == null ? " " : pass;
                        if (check.length < 8) {
                          return passError;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_email.text.isEmpty &&
                              _password.text.isEmpty &&
                              EmailValidator.validate(_email.text) &&
                              RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(_password.text) ==
                                  false) {
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const AuthState()));
                          }
                          _email.clear();
                          _password.clear();
                          _myIcon = Icon(null);
                        });
                      },
                      child: Text("Sign Up")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?",
                          style: TextStyle(color: Colors.blueGrey)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton.icon(
                    onPressed: (){
                      try{
                        final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                        provider.googleLogin(context);
                      }
                      catch (e){
                        print(e);
                      }
                    },
                    icon: FaIcon(FontAwesomeIcons.google), label: Text("Sign In with Google"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
