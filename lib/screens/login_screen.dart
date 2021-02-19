import 'package:family_chat/screens/chat_screen.dart';
import 'package:family_chat/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:family_chat/component/rounded_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth=FirebaseAuth.instance;
  var showSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 160.0,
                      child: Image.asset('assets/logo.jpg')
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                TextField(
                  onChanged: (value){
                    email=value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: kDecoration.copyWith(hintText: 'email'),
                ),
                SizedBox(height: 16.0,),
                TextField(
                  onChanged: (value){
                    password=value;
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: kDecoration.copyWith(hintText: 'password'),
                ),
                SizedBox(height: 40.0),
                ReusableButton(
                  title: 'Log in',
                  function: () async {
                    setState(() {
                      showSpinner=true;
                    });
                    try{
                      final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user!=null){
                        Navigator.pushNamed(context, ChatScreen.id,arguments:email);
                      }
                      setState(() {
                        showSpinner=false;
                      });
                    }catch(e){
                      print(e);
                    }
                  },
                )

              ],

            ),
          ),
        ),
      ),
    );
  }
}
