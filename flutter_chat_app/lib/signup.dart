import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/chatpage.dart';
import 'package:flutter_application_1/database_chatapp/database.dart';
import 'package:flutter_application_1/database_chatapp/shared_orefer.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signin_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String Name = "", Email = "", Password = "", ConfirmPassword = "";
  var imageurl;

  TextEditingController Namecontroller = new TextEditingController();
  TextEditingController Emailcontroller = new TextEditingController();
  TextEditingController Passwordcontroller = new TextEditingController();
  TextEditingController ConfirmPasswordcontroller = new TextEditingController();

  final _fromkey = GlobalKey<FormState>();

  SignUpFunction() async {
    if (Password != null &&
        Namecontroller.text.isNotEmpty &&
        Emailcontroller.text.isNotEmpty &&
        Password == ConfirmPassword) {
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
          "Password": Password,
          "Photo": imageurl,
        };
        await DataBaseMethod().addUserDetails(userInfoMap, Id);

        await SharePreferenceHelper().saveUserId(Id);
        await SharePreferenceHelper()
            .saveUserName(Emailcontroller.text.replaceAll("@gmail.com", ""));
        await SharePreferenceHelper().saveUserMail(Emailcontroller.text);
        await SharePreferenceHelper().saveUserDisplayName(Namecontroller.text);
        await SharePreferenceHelper().saveUserPhoto(imageurl);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign Up Successful")));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SinginPage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Password is too weak")));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This email is already in use")));
        } else if (e.code == "invalid-email") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This email is invalid in use")));
        } else {
          print("Error adding user details: $e");
        }
      } catch (e) {
        print("Error adding user details: $e");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }
    if (Password != ConfirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match.")));
      return;
    }
  }

  // image picker firebase
  TextEditingController _nameController = TextEditingController();
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseFirestore.instance;

  progressDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  writeData(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Add a photo"),
                    ),
                    Expanded(
                      child: image == null
                          ? Center(
                              child: IconButton(
                                onPressed: () async {
                                  XFile? pickedImage = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    setState(() {
                                      image = pickedImage;
                                    });
                                  }
                                },
                                icon: Icon(Icons.add_a_photo),
                              ),
                            )
                          : Image.file(
                              File(image!.path),
                              fit: BoxFit.contain,
                            ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No image selected")),
                          );
                          return;
                        }
                        try {
                          progressDialog();
                          File imgFile = File(image!.path);
                          UploadTask uploadTask = FirebaseStorage.instance
                              .ref("images")
                              .child(image!.name)
                              .putFile(imgFile);
                          TaskSnapshot snapshot = await uploadTask;
                          imageurl = await snapshot.ref.getDownloadURL();
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        } catch (e) {
                          print("Upload error: $e");
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Upload failed")),
                          );
                        }
                      },
                      child: Text("Upload"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                          height: MediaQuery.of(context).size.height / 1.33,
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
                                ElevatedButton(onPressed: (){ 
                                     writeData(context);
                                }, child: Text("Upload a photo")),
                                Text(
                                  "Name",
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
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your name";
                                      }
                                      return null;
                                    },
                                    controller: Namecontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                            Icons.person_outline_outlined,color: Colors.white54,)),
                                            style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 18,),
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
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your mail";
                                      }
                                      return null;
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
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a password";
                                      }
                                      return null;
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
                                Text(
                                  "Confirm Password",
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
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a password";
                                      }
                                      return null;
                                    },
                                    controller: ConfirmPasswordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.key_outlined,color: Colors.white54,)),
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
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
                                            ConfirmPassword =
                                                ConfirmPasswordcontroller.text;
                                          });
                                        }
                                        SignUpFunction();
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius:   BorderRadius.circular(20),
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
                                            "Sign Up",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SinginPage() ));
                                  },
                                    child: Center(
                                        child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )))
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
