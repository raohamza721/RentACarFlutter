import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingFormScreen extends StatefulWidget {
  final DocumentSnapshot carData;


   BookingFormScreen({required this.carData, Key? key}) : super(key: key);

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _whereToGoController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTimeRange? _selectedDateRange;

  @override
  void dispose() {
    _whereToGoController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _genderController.dispose();
    _cnicController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final bookingUserId = FirebaseAuth.instance.currentUser?.uid; // The user who is booking
        final carOwnerId = widget.carData['OwnerUserId']; // The owner of the car

        final bookingData = {
          'bookingUserId': bookingUserId, // User who is making the booking
          'carOwnerId': carOwnerId,       // The owner of the car
          'carId': widget.carData.id,     // Car ID
          'whereToGo': _whereToGoController.text,
          'whenToGo': '${_selectedDateRange!.start.toLocal()} to ${_selectedDateRange!.end.toLocal()}',
          'days': _selectedDateRange!.duration.inDays.toString(),
          'phone': _phoneController.text,
          'email': _emailController.text,
          'name': _nameController.text,
          'gender': _genderController.text,
          'cnic': _cnicController.text,
          'address': _addressController.text,
          'status': 'pending', // Booking status
        };

        // Submit the booking data to Firestore
        await FirebaseFirestore.instance.collection('rentalRequests').add(bookingData);

        // Display success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking request submitted successfully!')),
        );
      } catch (e) {
        // Handle the error (show a message to the user, etc.)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit booking request: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Car Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Make: ${widget.carData['carMake']}'),
                Text('Model: ${widget.carData['carModel']}'),
                Text('Year: ${widget.carData['carYear']}'),
                Text('Color: ${widget.carData['carColor']}'),
                const SizedBox(height: 16),
                const Text(
                  'Booking Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _whereToGoController,
                  decoration: const InputDecoration(labelText: 'Where to go'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the destination';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickDateRange,
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: _selectedDateRange == null
                            ? 'Select Dates'
                            : 'From: ${_selectedDateRange!.start.toLocal().toString().split(' ')[0]} to ${_selectedDateRange!.end.toLocal().toString().split(' ')[0]}',
                      ),
                      validator: (value) {
                        if (_selectedDateRange == null) {
                          return 'Please select a date range';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cnicController,
                  decoration: const InputDecoration(labelText: 'CNIC'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your CNIC';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
