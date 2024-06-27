import 'package:flutter/material.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({super.key});

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
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
                          height: MediaQuery.of(context).size.height / 2.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                
                                  
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,prefixIcon: Icon(Icons.mail_outline)),
                                        
                                  ),
                                
                              ),
                              SizedBox(height: 18,),
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
                                
                                  
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,prefixIcon: Icon(Icons.key_outlined)),
                                        
                                  ),
                                
                              )
                            ],
                          ),
                        ),
                      ),
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
