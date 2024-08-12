import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database_chatapp/database.dart';
import 'package:flutter_application_1/database_chatapp/shared_orefer.dart';
import 'package:flutter_application_1/home.dart';
import 'package:random_string/random_string.dart';

class ChatPage extends StatefulWidget {
  String name,username,mail;
  ChatPage( {required this.name,required this.username,required this.mail } );

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


TextEditingController _messagecontroller = new TextEditingController();

String? myname, myusername, mymail,chatroomId,messageId;

  Future<void> getthesharepre() async {
    myname = await SharePreferenceHelper().getUserDisplayName();
    myusername = await SharePreferenceHelper().getUserMail();
    mymail = await SharePreferenceHelper().getUserMail();
    chatroomId = getchatroomIdByUsername(widget.username, myusername!);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> ontheload() async {
    await getthesharepre();
    await getAndSetMessage();
    setState(() {
      
    });
  }
  
  getchatroomIdByUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b>$a";
    } else {
      return "$a>$b";
    }
  }
 

addMessage(bool sendclicked){ 

 if(_messagecontroller.text!=""){

  String message =_messagecontroller.text;
  _messagecontroller.text="";

  Map<String,dynamic> messageInfoMap={ 
    "Message": message,
    "sendBy" :myusername,
    "time": FieldValue.serverTimestamp(), 
  };
  messageId ??=randomAlphaNumeric(10);

 DataBaseMethod().addMessageFIrebase(chatroomId!, messageId!, messageInfoMap).then((value){ 
     
     Map<String,dynamic> LastmessageInfoMap={ 
    "lastMessage": message,
    "lastsendBy" :myusername,
    "lasttime": FieldValue.serverTimestamp(), 
  };
  DataBaseMethod().LastMessageFIrebase(chatroomId!, LastmessageInfoMap);
   if(sendclicked){
    messageId=null;
   }
 });

 }

}
Stream?messageStram;
 

 Widget chatMessageTile(String message,bool sendByme ){

  return Row(mainAxisAlignment: sendByme?MainAxisAlignment.end:MainAxisAlignment.start, 
   children: [ 
    Flexible(child: Container( 
     margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16 ),
        decoration: BoxDecoration( 
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24),bottomLeft: sendByme ? Radius.circular(0):Radius.circular(24), 
          topRight: Radius.circular(24),
          bottomRight: sendByme ? Radius.circular(24):Radius.circular(0)
          ),
          color: sendByme? Colors.blue:Colors.grey,
        
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
                             message,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
        ),
                        ),

    ),
    CircleAvatar( 
      backgroundColor: Colors.amber,
      radius: 20,
    )
   ]
    );

 }

Widget chatMessage() {
  return StreamBuilder(
    stream: messageStram,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          reverse: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return chatMessageTile(ds["Message"], myusername == ds["sendBy"]);
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

getAndSetMessage()async{ 
  messageStram =await DataBaseMethod().getChatroomMessage(chatroomId);
  setState(() {
    
  });

}





@override
  void initState() {
    // TODO: implement initState
    ontheload();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true,
    backgroundColor: Color.fromARGB(255, 66, 25, 90),
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Home()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(width: 30,height: 60,),
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 22, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: chatMessage(),
                      ),
                      SizedBox(height: 10),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _messagecontroller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    hintStyle: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addMessage(true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.send_outlined,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}