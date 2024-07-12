import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
                        "Sumi Akter",
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
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        hintStyle: TextStyle(
                                          color: Colors.black45,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.send_outlined,color: Colors.black45,),
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