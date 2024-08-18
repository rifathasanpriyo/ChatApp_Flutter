import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database_chatapp/database.dart';
import 'package:flutter_application_1/database_chatapp/shared_orefer.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({super.key});

  @override
  State<SinginPage> createState() => _SinginPageState();
}



class _SinginPageState extends State<SinginPage> {
String Name="",Email="",Username="",Password="",Id="";


TextEditingController Emailcontroller=new TextEditingController();
TextEditingController Passwordcontroller=new TextEditingController();

final _fromkey=GlobalKey<FormState>();


userSigning()async{

  try{ 
await FirebaseAuth.instance.signInWithEmailAndPassword(email: Email, password: Password);

QuerySnapshot querySnapshot= await DataBaseMethod().getUserByMail(Email);


Name= "${querySnapshot.docs[0]["Name"]}";
Username= "${querySnapshot.docs[0]["UserName"]}";
Id="${querySnapshot.docs[0]["Id"]}";

await SharePreferenceHelper().saveUserName(Name);
await SharePreferenceHelper().saveUserId(Id);
await SharePreferenceHelper().saveUserName(Username);


Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));

  }on FirebaseException catch(e){
    if(e.code=='user-not-found'){ 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found")));
    }else if(e.code=='worng-password'){ 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password")));
    }
 
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF7f30fe), Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 105))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Login Your Account",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 10),
                          height: MediaQuery.of(context).size.height / 1.8,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 27, 12, 52), Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: _fromkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white54),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if(value==null || value.isEmpty){
                                        return "Enter your mail";
                                      }
                                    },
                                    controller: Emailcontroller,
                                    decoration: InputDecoration(
                                        
                                        border: InputBorder.none,
                                        
                                        prefixIcon: Icon(Icons.mail_outline,color: Colors.white54,)),
                                        style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white54),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if(value==null || value.isEmpty){
                                        return "Enter your mail";
                                      }
                                    },
                                    controller: Passwordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.key_outlined,color: Colors.white54,)),
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Material(
                                    elevation: 15,
                                    child: GestureDetector(
                                      onTap: () {
                                         if(_fromkey.currentState!.validate()){ 

                                           setState(() {
                                             Email = Emailcontroller.text;
                                             Password = Passwordcontroller.text;
                                           });

                                         }
                                         userSigning();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                             gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 101, 58, 171), Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ 
                        Text("Don't have an account?",style: TextStyle( 
                          color: Colors.white,
                          fontSize: 16,
                        ),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
                          },
                          child: Text("Sign Up Now!",style: TextStyle( 
                            color: Colors.blue,
                            fontSize: 16,
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
