import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database_chatapp/database.dart';
import 'package:flutter_application_1/database_chatapp/shared_orefer.dart';
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
      body: Container(
            padding: EdgeInsets.only(top: 36),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white54,
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 22, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
                    height: MediaQuery.sizeOf(context).height / 1.13,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2),
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Text(
                            "Hello,How Are You?",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 2.5),
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 220, 211, 211),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Text(
                            "I am fine,What are you doing?",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        Spacer(),
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
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    addMessage(true);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.send_outlined,color: Colors.black45,),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      
      
    );
  }
}