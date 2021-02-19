import 'package:flutter/material.dart';
import 'package:family_chat/component/rounded_btn.dart';
import 'package:family_chat/utils/constants.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id='registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  final _auth=FirebaseAuth.instance;
  var showSpinnner = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinnner,
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
                  title: 'Register',
                  function: () async {
                    setState(() {
                      showSpinnner=true;
                    });
                  try{
                    final newUser =await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser!=null){
                      Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                    }
                    setState(() {
                      showSpinnner=false;
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
