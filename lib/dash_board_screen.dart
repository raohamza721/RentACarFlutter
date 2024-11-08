import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentacar/ad_your_car_form.dart';
import 'package:rentacar/bookings.dart';
import 'package:rentacar/faqs.dart';
import 'package:rentacar/my_cars_ads.dart';
import 'package:rentacar/rent_a_car_requests.dart';
import 'package:rentacar/setting.dart';
import 'user_profile_screen.dart';
import 'home_screen.dart';


class DashBoardScreen extends StatefulWidget {
  final String userId;
   const DashBoardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic>? userData;

  final List<Widget> _widgetOptions = <Widget>[

     Dashboard(userId: '',),
    const MessagesScreenContent(),
    const HomeScreen(),
    const NotificationsScreenContent(),
    const Setting(),

  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();

    if (userDoc.exists) {
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectedIndex == 2 || _selectedIndex == 4) ? null : AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(userId: widget.userId),
                ),
              );
            },
            child: CircleAvatar(
              radius: 24,
              backgroundImage: userData?['profilePhotoUrl'] != null
                  ? NetworkImage(userData!['profilePhotoUrl'])
                  : const AssetImage('assets/images/profile.png') as ImageProvider,
              // Replace with actual image asset or network image
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),

      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          // Handle the action when the FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>   AddCarForm(userId: widget.userId), // Navigate to your desired screen
            ),
          );
        },

        child: const Icon(Icons.add),
      )
          : null, // Only show FAB on the Dashboard screen (index 0)
    );
  }
}

class Dashboard extends StatefulWidget {
  final String userId;
  const Dashboard({super.key, required this.userId});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return
      ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Welcome Message
        const Text(
          'Welcome, Hamza!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),

        // Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for cars...',
              prefixIcon: const Icon(Icons.add),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        // Featured Cars/Deals
        const Text(
          'Featured Cars',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCarCard('Land Rover', 'assets/images/car1.png'),
              _buildCarCard('Honda', 'assets/images/car2.png'),
              _buildCarCard('Ford', 'assets/images/car3.png'),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Categories or Filters
        const Text(
          'Dashboard',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics:  const NeverScrollableScrollPhysics(),
          children: [
            InkWell(onTap: (){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  MyCarsAds(userId: widget.userId )));
            },
                child: _buildCategoryCard('My Car', FontAwesomeIcons.car)),
            InkWell(onTap: ( ){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BookingScreen()));

            },
                child: _buildCategoryCard('Bookings', FontAwesomeIcons.carSide)),
            InkWell(onTap: ( ){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  RentACarRequestScreen(userId: widget.userId)));

            },
                child: _buildCategoryCard('Rent Requests', FontAwesomeIcons.carRear)),
            InkWell(onTap: ( ){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FaqScreeen()));

            },child: _buildCategoryCard('FAQs', FontAwesomeIcons.bolt)),
          ],
        ),
        const SizedBox(height: 16.0),

        // Offers and Promotions
        const Text(
          'Offers & Promotions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        _buildOfferCard('Special Deal', 'Get 20% off on SUVs!'),
    ],
      );
  }

  Widget _buildCarCard(String title, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          Image.asset(imagePath, height: 120, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(height: 8.0),
          Text(title, style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesScreenContent extends StatelessWidget {
  const MessagesScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Messages Screen'),
    );
  }
}

class NotificationsScreenContent extends StatelessWidget {
  const NotificationsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notifications Screen'),
    );
  }
}


