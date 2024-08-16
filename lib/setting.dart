import 'package:flutter/material.dart';
import 'package:rentacar/user_profile_screen.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Setting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Image and ID
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/profile.png"), // Replace with your image URL or asset
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Profile ID: 12345', // Replace with dynamic profile ID
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
        
              // Account Profile List Tile
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Account Profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserProfileScreen(userId: "")));
                },
              ),
        
              const Divider(),
        
              // Billing List Tile
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Billing'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Billing
                },
              ),
        
              const Divider(),
        
              // Change Password List Tile
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Change Password
                },
              ),
        
              const Divider(),
        
              // Notifications List Tile
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Notifications
        
        
                },
              ),
              const SizedBox(height: 180,),
        
        
            Card(
        elevation: 10,
        child: ListTile(tileColor: Colors.black,
        leading: const Icon(Icons.logout,color: Colors.white,),
        title: const Center(child: Text('LOGOUT',style: TextStyle(color: Colors.white))),
        onTap: () {
        // Navigate to Notifications
        },
                ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}