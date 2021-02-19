import 'package:family_chat/screens/login_screen.dart';
import 'package:family_chat/screens/registration_screen.dart';
import 'package:family_chat/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:family_chat/component/rounded_btn.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller=AnimationController(duration: Duration(seconds: 2),vsync: this);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/logo.jpg'),
                height: controller.value*100,
              ),
            ),
            SizedBox(height: 20.0,),
            TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 500),
                text:['Family Chat'],
                textAlign: TextAlign.center,
                textStyle: kTitleTextStyle
            ),
            SizedBox(height: 40.0,),

            ReusableButton(
              title: 'Login',
              function: (){
                Navigator.pushNamed(context,LoginScreen.id );
              },
            ),

            ReusableButton(
              title: 'Registration',
              function: (){
                Navigator.pushNamed(context,RegistrationScreen.id);
              },
            ),

          ],
        ),
      ),
    );
  }
}
