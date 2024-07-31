import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chatpage.dart';
import 'package:flutter_application_1/database_chatapp/database.dart';
import 'package:flutter_application_1/database_chatapp/shared_orefer.dart';
import 'package:flutter_application_1/home.dart';
import 'package:random_string/random_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String Name = "", Email = "", Password = "";

  TextEditingController Namecontroller = new TextEditingController();
  TextEditingController Emailcontroller = new TextEditingController();
  TextEditingController Passwordcontroller = new TextEditingController();

  final _fromkey = GlobalKey<FormState>();

  SignUpFunction() async {
    if (Password != null &&
        Namecontroller.text.isNotEmpty &&
        Emailcontroller.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Email,
          password: Password,
        );

        String Id = randomAlphaNumeric(10);

        Map<String, dynamic> userInfoMap = {
          "Name": Namecontroller.text,
          "Email": Emailcontroller.text,
          "UserName": Emailcontroller.text.replaceAll("@gmail.com", ""),
          //"Photo":"images/profilepic.png",
          "Id": Id,
        };
        await DataBaseMethod().addUserDetails(userInfoMap, Id);

        await SharePreferenceHelper().saveUserId(Id);
        await SharePreferenceHelper()
            .saveUserName(Emailcontroller.text.replaceAll("@gmail.com", ""));
        await SharePreferenceHelper().saveUserMail(Emailcontroller.text);
        await SharePreferenceHelper().saveUserDisplayName(Namecontroller.text);
        //await SharePreferenceHelper().saveUserPhoto("images/profilepic.png");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign Up Successful")));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Password is too weak")));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This email is already in use")));
        }
      } catch (e) {
       print("Error adding user details: $e");
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Sign Up",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Create An Account",
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
                          height: MediaQuery.of(context).size.height / 1.37,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: _fromkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black87),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your name";
                                      }
                                      return null;
                                    },
                                    controller: Namecontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                            Icons.person_outline_outlined)),
                                  ),
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black87),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your mail";
                                      }
                                      return null;
                                    },
                                    controller: Emailcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.mail_outline)),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black87),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a password";
                                      }
                                      return null;
                                    },
                                    controller: Passwordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.key_outlined)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black87),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.key_outlined)),
                                    obscureText: true,
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
                                        if (_fromkey.currentState!.validate()) {
                                          setState(() {
                                            Name = Namecontroller.text;
                                            Email = Emailcontroller.text;
                                            Password = Passwordcontroller.text;
                                          });
                                        }
                                        SignUpFunction();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF7f30fe),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Sign Up",
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
