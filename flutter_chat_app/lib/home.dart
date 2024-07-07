import 'package:flutter/material.dart';

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
         
        decoration:  BoxDecoration( 
          
        ),
        child:  Column( 
          children: [ 
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 20),
             child: Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Text("Chat APP",style: TextStyle( 
                  fontSize: 22,
                  color: Colors.white
                ),),
                Container( 
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration( 
                    color:Color.fromARGB(255, 33, 4, 49),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:  
                  Icon(Icons.search,color: Color.fromARGB(199, 230, 227, 227),),
                ),
                
              ],
             ),
           ),
           Container( 
                height: MediaQuery.sizeOf(context).height/1.15,
                width: MediaQuery.sizeOf(context).width,
                decoration:  
                BoxDecoration( 
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
              ),
          ],
        ),
      ),
    );
  }
}