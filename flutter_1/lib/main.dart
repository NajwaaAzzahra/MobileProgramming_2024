import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OceanTherapyScreen(),
    );
  }
}

class OceanTherapyScreen extends StatefulWidget {
  @override
  _OceanTherapyScreenState createState() => _OceanTherapyScreenState();
}

class _OceanTherapyScreenState extends State<OceanTherapyScreen> {
  int _selectedIndex = 0; // State for the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0'), // URL gambar sesuai
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Bottom right icons and text (likes, comments, share)
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                    Text('92.3K', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Icon(Icons.comment, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                    Text('100', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Icon(Icons.share, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                    Text('3.9K', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Icon(Icons.more_horiz, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),

          // Bottom left profile icon and username
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1705346435684-a9de6cbb53dc?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // URL gambar profil
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'dgsc',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Feel the stress wash away 🌊',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Set the current index
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped, // Handle item tap
      ),
    );
  }
}
