import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatScreen extends StatefulWidget {
  static const String id='chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore=FirebaseFirestore.instance;
  final messageTextController=TextEditingController();
  String messagetext;
  String userEmail;


  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async{
    final user =_auth.currentUser;
    if(user!=null){
      userEmail=user.email;
      print(user.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('messages').snapshots(),
            // ignore: missing_return
            builder: (context,snapshot){
              if(snapshot.hasData){
                final messages=snapshot.data.docs.reversed;
                List<MessageCard> textWidgets=[];
                for(var message in messages){
                  final messageText=message.data()['text'];
                  final messageSender=message.data()['sender'];
                  final loggedUser=ModalRoute.of(context).settings.arguments;

                  final messageWidget=MessageCard(messageSender: messageSender,messageText: messageText,isUser: loggedUser==messageSender,);
                  textWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                    children: textWidgets,
                  ),
                ) ;

              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value){
                        messagetext=value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Message',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
               MaterialButton(
                   onPressed: (){
                     messageTextController.clear();
                     _fireStore.collection('messages').add({
                       'text':messagetext,
                       'sender':userEmail
                     });
                   },
                   child:Icon(Icons.send) )
              ],
            ),
          )

        ],
      ),
    );
  }
}


// ignore: must_be_immutable
class MessageCard extends StatelessWidget {
  String messageText;
  String messageSender;
  bool isUser;

  MessageCard({this.messageSender,this.messageText,this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 10.0),
      child: Column(
        crossAxisAlignment: isUser? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5.0,
            color: isUser? Colors.blueGrey:Colors.white,
            borderRadius: isUser ? BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight:Radius.circular(10.0),topLeft: Radius.circular(10.0)):
                BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight:Radius.circular(10.0),topRight:Radius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('$messageText',
                style:  TextStyle(
                    color: isUser ? Colors.white : Colors.black54,
                    fontSize: 17.0)),
            ),
    )
        ]
      ),
    );
  }
}

