import 'package:flutter/material.dart';


class Setting extends StatefulWidget {
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
                  // Navigate to Account Profile
                },
              ),
        
              Divider(),
        
              // Billing List Tile
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Billing'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Billing
                },
              ),
        
              Divider(),
        
              // Change Password List Tile
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_forward_ios),
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
              SizedBox(height: 180,),
        
        
            Card(
        elevation: 10,
        child: ListTile(tileColor: Colors.black,
        leading: const Icon(Icons.logout,color: Colors.white,),
        title: Center(child: const Text('LOGOUT',style: TextStyle(color: Colors.white))),
        onTap: () {
        // Navigate to Notifications
        },
        //         ElevatedButton(onPressed: (){},
        //         style: ElevatedButton.styleFrom(
        //           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 140.0),
        //           backgroundColor: Colors.black,shape: const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.zero, // Rectangular shape
        // ),
        // elevation: 5.0, // Shadow effect
        // shadowColor: Colors.black, // Shadow color
        // ),
        //           child: Text('LOGOUT',style: TextStyle(color: Colors.white ) ,),
        
                ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}