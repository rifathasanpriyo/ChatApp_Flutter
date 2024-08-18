import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin_page.dart';

class ProfileInfoPage extends StatelessWidget {
  final String name, username, mail;
  final dynamic photo;

  // Constructor with required parameters
  ProfileInfoPage({
    required this.name,
    required this.username,
    required this.mail,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Info",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture and Name
            Container(
              color: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                  backgroundImage: photo != null
                        ? NetworkImage(photo)
                        : AssetImage('assets/default_avatar.png') as ImageProvider, // Replace with your default image path
                  ),
                  const SizedBox(width: 20),
                  // Name and Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Available", // You can replace this with a status variable if needed
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Contact Information
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text("Username"),
              subtitle: Text(username),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text("Email"),
              subtitle: Text(mail),
            ),
            Divider(),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){ 
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SinginPage() ));
             
            }, child: Text("Log Out"))
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}