import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCarForm extends StatefulWidget {

  final String userId;

  const AddCarForm({Key? key, required this.userId}) : super(key: key);

  @override
  _AddCarFormState createState() => _AddCarFormState();
}

class _AddCarFormState extends State<AddCarForm> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _carMakeController = TextEditingController();
  final TextEditingController _carYearController = TextEditingController();
  final TextEditingController _carColorController = TextEditingController();
  final TextEditingController _pricePerDayController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create a map to store the car details
        Map<String, dynamic> carData = {
          'userId': widget.userId,
          'carModel': _carModelController.text,
          'carMake': _carMakeController.text,
          'carYear': _carYearController.text,
          'carColor': _carColorController.text,
          'pricePerDay': _pricePerDayController.text,
          'description': _descriptionController.text,
          'imageUrl': '', // Placeholder, update this after uploading the image
        };

        // Upload the image to Firebase Storage if an image was selected
        if (_imageFile != null) {
          String fileName = 'car_images/${DateTime.now().millisecondsSinceEpoch}.png';
          final storageRef = FirebaseStorage.instance.ref().child(fileName);
          final uploadTask = await storageRef.putFile(File(_imageFile!.path));
          final imageUrl = await uploadTask.ref.getDownloadURL();
          carData['imageUrl'] = imageUrl;
        }

        // Save the car details to Firestore
        await FirebaseFirestore.instance.collection('carsDetails').add(carData);

        // Show a success message and possibly navigate back or clear the form
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Car added successfully!')));
        Navigator.pop(context); // Navigate back after successful submission
      } catch (e) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add car: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Car for Rent'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _carModelController,
                  decoration: const InputDecoration(
                    labelText: 'Car Model',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car model';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _carMakeController,
                  decoration: const InputDecoration(
                    labelText: 'Car Make',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car make';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _carYearController,
                  decoration: const InputDecoration(
                    labelText: 'Car Year',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _carColorController,
                  decoration: const InputDecoration(
                    labelText: 'Car Color',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car color';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _pricePerDayController,
                  decoration: const InputDecoration(
                    labelText: 'Price per Day',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price per day';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _imageFile == null
                        ? const Center(child: Text('Tap to select an image'))
                        : Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
