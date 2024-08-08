import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool search = false;
   final TextEditingController _searchController = new TextEditingController();
   var resultList =[];

       @override
  void initState() {
    
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }
  _onSearchChanged(){ 
    print(_searchController.text);
    showSearchResult();
  }


      List allResults=[];
      getClientStream()async{ 
             var data = await FirebaseFirestore.instance.collection("users").orderBy("Name").get();
             setState(() {
               allResults=data.docs;
             });
             showSearchResult();


      }
      @override
  void dispose() {
      _searchController.removeListener(_onSearchChanged);
      _searchController.dispose();

     super.dispose();
  }
  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  showSearchResult(){ 
    var ShowResult =[];
    if(_searchController.text!=""){ 
      for(var clinetshot in allResults){ 

        var name = clinetshot['Name'].toString().toLowerCase();

        if(name.contains(_searchController.text.toLowerCase())){ 

          ShowResult.add(clinetshot);
        }
      }
    }
    setState(() {
      resultList =ShowResult;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 66, 25, 90),
      body: Container(
            
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Padding(
               padding:  EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 search? Expanded(
                   child: TextField( 
                    controller: _searchController,
                    decoration: InputDecoration( border: InputBorder.none ,hintText: "Search Here",hintStyle: TextStyle( 
                     
                      color: Colors.white70

                    ),),style: TextStyle(color: Colors.white),
                   ),
                 ) :Text(
                    "Chat APP",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                     
                      setState(() {
                        search=!search;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 33, 4, 49),
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.search,
                        color: Color.fromARGB(199, 230, 227, 227),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Expanded(
              child: Container(
                padding:  search ? EdgeInsets.symmetric(vertical: 5, horizontal:5) : EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                height:search ?MediaQuery.sizeOf(context).height / 1.16 : MediaQuery.sizeOf(context).height / 1.15,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: search ?  ListView.builder( 
              itemCount: resultList.length,
              itemBuilder:(context,Index){ 
                  return ListTile( 
                    title: Text(resultList[Index]['Name']),
                    subtitle:Text(resultList[Index]['Email']) ,
                  );
                 
            }  )   : Column(
                  children: [
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
            ),
          ],
        ),
      ),
    );
  }
}
