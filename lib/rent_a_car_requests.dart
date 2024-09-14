import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rentacar/dash_board_screen.dart';

class RentACarRequestScreen extends StatelessWidget {
  final String userId ;
  const RentACarRequestScreen({Key? key, required this.userId}) : super(key: key);

  Future<QuerySnapshot> _fetchPendingRequests() async {
    final ownerId = FirebaseAuth.instance.currentUser?.uid;

    // Query to fetch pending requests for the cars owned by the current user
    return await FirebaseFirestore.instance
        .collection('rentalRequests')
        .where('carOwnerId', isEqualTo: ownerId) // Filter by owner ID
        .where('status', isEqualTo: 'pending') // Only pending requests
        .get();
  }


  Future<void> _updateRequestStatus(String requestId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('rentalRequests')
          .doc(requestId)
          .update({
        'status': newStatus,
        if (newStatus == 'Accepted') 'Booked': true, // Add 'Booked' field if accepted
      });
    } catch (e) {
      // Handle error if necessary
      if (kDebugMode) {
        print('Error updating status: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  InkWell(onTap: (){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(userId: "userId")));
        },child: const Icon( Icons.arrow_back,)),
        title: const Text('Pending Requests'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _fetchPendingRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No pending requests found.'),
            );
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Request from: ${request['name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${request['phone']}'),
                      Text('Email: ${request['email']}'),
                      Text('Where to go: ${request['whereToGo']}'),
                      Text('When to go: ${request['whenToGo']}'),
                      Text('Days: ${request['days']}'),
                      Text('Status: ${request['status']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          _updateRequestStatus(request.id, 'Accepted');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          _updateRequestStatus(request.id, 'Rejected');
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Handle tap event, e.g., navigate to detailed request view
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
