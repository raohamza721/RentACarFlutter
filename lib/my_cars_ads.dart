import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentacar/dash_board_screen.dart';


class MyCarsAds extends StatefulWidget {
  final String userId;

  const MyCarsAds({super.key, required this.userId});

  @override
  _MyCarsAdsState createState() => _MyCarsAdsState();
}

class _MyCarsAdsState extends State<MyCarsAds> {
  final String userId = FirebaseAuth.instance.currentUser!.uid; // Get the current user's ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(userId: "")));
        },
            child: const Icon(Icons.arrow_back)),
        title: const Text('My Uploaded Cars'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carsDetails')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No cars uploaded yet.'));
          }

          // Separate cars by status
          final liveCars = snapshot.data!.docs.where((doc) => doc['status'] == 'live').toList();
          final bookedCars = snapshot.data!.docs.where((doc) => doc['status'] == 'booked').toList();

          return ListView(
            children: [
              if (liveCars.isNotEmpty)
                _buildCategory('Live Cars', liveCars),
              if (bookedCars.isNotEmpty)
                _buildCategory('Booked Cars', bookedCars),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategory(String categoryTitle, List<QueryDocumentSnapshot> cars) {
    return ExpansionTile(
      title: Text(categoryTitle),
      children: cars.map((car) {
        return ListTile(
          leading: car['imageUrl'] != ''
              ? Image.network(car['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
              : const Icon(Icons.directions_car),
          title: Text('${car['carMake']} ${car['carModel']}'),
          subtitle: Text('Year: ${car['carYear']} - Color: ${car['carColor']}'),
          trailing: Text('\$${car['pricePerDay']}/day'),
          onTap: () {
            // Navigate to the car detail screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarDetailScreen(car: car),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}


class CarDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('${car['carMake']} ${car['carModel']} Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display image or fallback icon
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: car['imageUrl'] != ''
                    ? Image.network(car['imageUrl'], width: double.infinity, height: 250, fit: BoxFit.cover)
                    : Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.directions_car, size: 100, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              // Car details section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Car Model', car['carModel']),
                      _buildDetailRow('Car Make', car['carMake']),
                      _buildDetailRow('Year', car['carYear']),
                      _buildDetailRow('Color', car['carColor']),
                      _buildDetailRow('Price Per Day', '\$${car['pricePerDay']}'),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        car['description'],
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A helper method to build a row for car details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

