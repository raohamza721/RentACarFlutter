import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Rental App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
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
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
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
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for cars ',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('carsDetails').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No cars available'));
                }

                final carDocs = snapshot.data!.docs.where((doc) {
                  final carModel = doc['carModel'].toString().toLowerCase();
                  final carMake = doc['carMake'].toString().toLowerCase();
                  final carYear = doc['carYear'].toString().toLowerCase();
                  final carColor = doc['carColor'].toString().toLowerCase();
                  final pricePerDay = doc['pricePerDay'].toString().toLowerCase();

                  return carModel.contains(_searchQuery) ||
                      carMake.contains(_searchQuery) ||
                      carYear.contains(_searchQuery) ||
                      carColor.contains(_searchQuery) ||
                      pricePerDay.contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: carDocs.length,
                  itemBuilder: (context, index) {
                    final carData = carDocs[index];
                    final carModel = carData['carModel'] ?? 'Unknown Model';
                    final pricePerDay = carData['pricePerDay'] ?? 'N/A';
                    final imageUrl = carData['imageUrl'];

                    return _buildCarItem(carData, carModel, pricePerDay, imageUrl);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarItem(DocumentSnapshot carData, String title, String price, String imageUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ExpansionTile(
        leading: Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text('Price per day: \$$price'),
        trailing: const Icon(Icons.expand_more),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl.isNotEmpty)
                  Image.network(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
                const SizedBox(height: 16),
                _buildDetailRow('Car Make', carData['carMake']),
                _buildDetailRow('Car Model', carData['carModel']),
                _buildDetailRow('Year', carData['carYear']),
                _buildDetailRow('Color', carData['carColor']),
                _buildDetailRow('Price Per Day', '\$${carData['pricePerDay']}'),
                const SizedBox(height: 8),
                Text(
                  'Description',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  carData['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle rent request action
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Book Now'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle messaging action
                        },
                        icon: const Icon(Icons.message),
                        label: const Text('Message'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle view profile action
                        },
                        icon: const Icon(Icons.person),
                        label: const Text('Message'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle view profile action
                        },
                        icon: const Icon(Icons.person),
                        label: const Text('View Profile'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
