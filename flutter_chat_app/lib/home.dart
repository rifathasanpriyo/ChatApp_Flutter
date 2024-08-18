import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/chatpage.dart';
import 'package:flutter_application_1/database_chatapp/database.dart';
import 'package:flutter_application_1/database_chatapp/shared_orefer.dart';
import 'package:flutter_application_1/profile_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;
  final TextEditingController _searchController = TextEditingController();
  var resultList = [];

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    ontheload();
    super.initState();
  }

  _onSearchChanged() {
    showSearchResult();
  }

  List allResults = [];

  Future<void> getClientStream() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("Name")
          .get();

      if (mounted) {
        setState(() {
          allResults = data.docs;
        });
        showSearchResult();
      }
    } catch (e) {
      print("Error fetching client stream: $e");
    }
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

  showSearchResult() {
    var showResult = [];
    if (_searchController.text.isNotEmpty) {
      for (var clientSnapshot in allResults) {
        var name = clientSnapshot['Name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(clientSnapshot);
        }
      }
    }
    if (mounted) {
      setState(() {
        resultList = showResult;
      });
    }
  }

  String? myname, myusername, mymail;
  var myimage;

  Future<void> getthesharepre() async {
    myname = await SharePreferenceHelper().getUserDisplayName();
    myusername = await SharePreferenceHelper().getUserName();
    mymail = await SharePreferenceHelper().getUserMail();
    myimage = await SharePreferenceHelper().getUserPhoto();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.purple,
      drawer: Drawer(),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8, right: 20, top: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  search
                      ? Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Here",
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : Row(
                        children: [
                          Container(
                            
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 4, 49),
                          borderRadius: BorderRadius.circular(20)),
                            child: IconButton(onPressed: (){ 
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileInfoPage(name:myname! ,username: myusername!, mail: mymail!,photo: myimage)));
                            }, icon: Icon(Icons.person_4_sharp,color: Colors.white,size: 30,)),
                          ),
                          SizedBox(width: 6,),
                          const Text(
                              "Chat APP",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          search = !search;
                          _searchController.clear();
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 4, 49),
                          borderRadius: BorderRadius.circular(20)),
                      child: search
                          ? const Icon(
                              Icons.close,
                              color: Color.fromARGB(199, 230, 227, 227),
                            )
                          : const Icon(
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
                padding: search
                    ? const EdgeInsets.symmetric(vertical: 5, horizontal: 5)
                    : const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                height: search
                    ? MediaQuery.sizeOf(context).height / 1.16
                    : MediaQuery.sizeOf(context).height / 1.15,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: search
                    ? ListView.builder(
                        itemCount: resultList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              var chatroomId = getchatroomIdByUsername(
                                  myusername!, resultList[index]['UserName']);
                              Map<String, dynamic> chatroomInfoMap = {
                                "users": [
                                  myusername,
                                  resultList[index]['UserName']
                                ],
                              };

                              await DataBaseMethod()
                                  .createChatRoom(chatroomId, chatroomInfoMap);

                              if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      name: resultList[index]["Name"],
                                      username: resultList[index]["UserName"],
                                      mail: resultList[index]["Email"],
                                      photo: resultList[index]["Photo"],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: resultList[index]['Photo'] !=
                                        null
                                    ? NetworkImage(resultList[index]['Photo'])
                                    : null,
                                child: resultList[index]['Photo'] == null
                                    ? Text(resultList[index]['Name'][0])
                                    : null,
                              ),
                              title: Text(resultList[index]['Name']),
                              subtitle: Text(resultList[index]['Email']),
                            ),
                          );
                        })
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ChatPage(
                                          name: "Sheikh Hasina",
                                          username: "sheikhhasina3314",
                                          mail: "sheikhhasina3314@gmail.com",
                                          photo:
                                              "https://firebasestorage.googleapis.com/v0/b/chatapp-ci-be5d3.appspot.com/o/images%2F1000000037.jpg?alt=media&token=3e8ca925-70fa-4ba2-b6cc-b01af76747f0")));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.asset(
                                    "images/shei.png",
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Sheikh Hasina",
                                        
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Hi,What are you doing?",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "04:18 PM",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black45),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
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
                              const SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Rifat Hasan Priyo",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Do you know what....",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                "07:23 PM",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black45),
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
