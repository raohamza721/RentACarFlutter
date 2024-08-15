import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyCarsAdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('cars').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No cars available.'));
                }

                final cars = snapshot.data!.docs.map((doc) {
                  return Car(
                    model: doc['model'],
                    make: doc['make'],
                    year: doc['year'],
                    color: doc['color'],
                    price: doc['price'],
                    description: doc['description'],
                    imageFile: doc['imageUrl'] != null
                        ? XFile(doc['imageUrl'])
                        : null, // Assuming imageUrl is a URL or file path
                  );
                }).toList();

                return ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return _buildCarItem(cars[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarItem(Car car) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: car.imageFile != null
            ? Image.file(
          File(car.imageFile!.path),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        )
            : Image.asset('assets/images/default_car.png', width: 100, height: 100, fit: BoxFit.cover),
        title: Text(car.model, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text('Price per day: \$${car.price}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class Car {
  final String model;
  final String make;
  final String year;
  final String color;
  final String price;
  final String description;
  final XFile? imageFile;

  Car({
    required this.model,
    required this.make,
    required this.year,
    required this.color,
    required this.price,
    required this.description,
    this.imageFile,
  });
}
