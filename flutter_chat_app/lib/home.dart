import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 66, 25, 90),
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chat APP",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 33, 4, 49),
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(199, 230, 227, 227),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              height: MediaQuery.sizeOf(context).height / 1.15,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset(
                          "images/usa_girls.png",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           
                          children: [
                            Text(
                              "Sumi Akter",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "Hi,What are you doing?",
                              style: TextStyle(
                                  fontSize: 16, 
                                  //fontWeight: FontWeight.w300,
                                  color: Colors.black45
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                            "04:18 PM",
                            style: TextStyle(
                                fontSize: 14, 
                                //fontWeight: FontWeight.w300,
                                color: Colors.black45
                                ),
                          ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset(
                          "images/rifathasan.jpg",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           
                          children: [
                            Text(
                              "Rifat Hasan Priyo",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "Do you know what....",
                              style: TextStyle(
                                  fontSize: 16, 
                                  //fontWeight: FontWeight.w300,
                                  color: Colors.black45
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                            "07:23 PM",
                            style: TextStyle(
                                fontSize: 14, 
                                //fontWeight: FontWeight.w300,
                                color: Colors.black45
                                ),
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
