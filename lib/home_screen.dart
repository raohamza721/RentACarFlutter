import 'package:flutter/material.dart';
import 'package:rentacar/user_profile_screen.dart'; // Import the ProfileScreen
 // Import the SettingsScreenContent

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(

          title: const Text('Car Rental App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            const CircleAvatar(

              backgroundImage: AssetImage(
                  'assets/images/profile.png'), // Replace with actual image asset or network image
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0; // Navigate to Home screen
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 4; // Navigate to Profile screen
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3; // Navigate to Settings screen
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Messages'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1; // Navigate to Messages screen
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for cars...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                // Replace with the actual number of available cars
                itemBuilder: (context, index) {
                  return _buildCarItem(
                      'Car ${index + 1}', 'assets/images/car${index + 1}.png');
                },
              ),
            ),
          ],
        ),
    );
  }
}

  Widget _buildCarItem(String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: const Text('Price per day: \$XX.XX'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Handle car item tap
        },
      ),
    );
  }

