import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCe9rbKrY4fZNII7Mk4pF5jkkCeD_G0Z_w",
      authDomain: "smart-grocery-price-comparator.firebaseapp.com",
      projectId: "smart-grocery-price-comparator",
      storageBucket: "smart-grocery-price-comparator.firebasestorage.app",
      messagingSenderId: "139120870100",
      appId: "1:139120870100:android:f1a0643510d016456bf141",
    ),
  );
  runApp(const GroceryApp());
}

List<Map<String, dynamic>> getDemoGroceries() {
  return [
    {'Name': 'Basmati Rice', 'category': 'Grains', 'balayya': 56, 'sai RAM': 52, 'medium Bazzer': 58},
    {'Name': 'Toor Dal', 'category': 'Dal', 'balayya': 110, 'sai RAM': 104, 'medium Bazzer': 118},
    {'Name': 'Urad Dal', 'category': 'Dal', 'balayya': 115, 'sai RAM': 108, 'medium Bazzer': 120},
    {'Name': 'Moong Dal', 'category': 'Dal', 'balayya': 102, 'sai RAM': 99, 'medium Bazzer': 106},
    {'Name': 'Chana Dal', 'category': 'Dal', 'balayya': 98, 'sai RAM': 95, 'medium Bazzer': 100},
    {'Name': 'Whole Wheat Flour', 'category': 'Grains', 'balayya': 42, 'sai RAM': 39, 'medium Bazzer': 45},
    {'Name': 'Maida', 'category': 'Grains', 'balayya': 48, 'sai RAM': 46, 'medium Bazzer': 49},
    {'Name': 'Semolina', 'category': 'Grains', 'balayya': 38, 'sai RAM': 36, 'medium Bazzer': 40},
    {'Name': 'Oats', 'category': 'Grains', 'balayya': 90, 'sai RAM': 88, 'medium Bazzer': 92},
    {'Name': 'Milk', 'category': 'Dairy', 'balayya': 58, 'sai RAM': 60, 'medium Bazzer': 55},
    {'Name': 'Curd', 'category': 'Dairy', 'balayya': 42, 'sai RAM': 40, 'medium Bazzer': 44},
    {'Name': 'Butter', 'category': 'Dairy', 'balayya': 72, 'sai RAM': 70, 'medium Bazzer': 74},
    {'Name': 'Paneer', 'category': 'Dairy', 'balayya': 120, 'sai RAM': 118, 'medium Bazzer': 124},
    {'Name': 'Cheese', 'category': 'Dairy', 'balayya': 140, 'sai RAM': 138, 'medium Bazzer': 145},
    {'Name': 'Tomato', 'category': 'Vegetables', 'balayya': 40, 'sai RAM': 38, 'medium Bazzer': 42},
    {'Name': 'Onion', 'category': 'Vegetables', 'balayya': 30, 'sai RAM': 28, 'medium Bazzer': 32},
    {'Name': 'Potato', 'category': 'Vegetables', 'balayya': 35, 'sai RAM': 33, 'medium Bazzer': 36},
    {'Name': 'Carrot', 'category': 'Vegetables', 'balayya': 32, 'sai RAM': 30, 'medium Bazzer': 34},
    {'Name': 'Beans', 'category': 'Vegetables', 'balayya': 45, 'sai RAM': 43, 'medium Bazzer': 47},
    {'Name': 'Cauliflower', 'category': 'Vegetables', 'balayya': 36, 'sai RAM': 35, 'medium Bazzer': 37},
    {'Name': 'Cabbage', 'category': 'Vegetables', 'balayya': 28, 'sai RAM': 27, 'medium Bazzer': 29},
    {'Name': 'Apple', 'category': 'Fruits', 'balayya': 180, 'sai RAM': 175, 'medium Bazzer': 190},
    {'Name': 'Banana', 'category': 'Fruits', 'balayya': 55, 'sai RAM': 52, 'medium Bazzer': 58},
    {'Name': 'Orange', 'category': 'Fruits', 'balayya': 80, 'sai RAM': 78, 'medium Bazzer': 84},
    {'Name': 'Grapes', 'category': 'Fruits', 'balayya': 95, 'sai RAM': 90, 'medium Bazzer': 99},
    {'Name': 'Mango', 'category': 'Fruits', 'balayya': 140, 'sai RAM': 136, 'medium Bazzer': 145},
    {'Name': 'Pineapple', 'category': 'Fruits', 'balayya': 110, 'sai RAM': 108, 'medium Bazzer': 112},
    {'Name': 'Watermelon', 'category': 'Fruits', 'balayya': 70, 'sai RAM': 68, 'medium Bazzer': 72},
    {'Name': 'Sunflower Oil', 'category': 'Oil & Spices', 'balayya': 160, 'sai RAM': 155, 'medium Bazzer': 165},
    {'Name': 'Mustard Oil', 'category': 'Oil & Spices', 'balayya': 170, 'sai RAM': 168, 'medium Bazzer': 174},
    {'Name': 'Coconut Oil', 'category': 'Oil & Spices', 'balayya': 180, 'sai RAM': 176, 'medium Bazzer': 185},
    {'Name': 'Turmeric', 'category': 'Oil & Spices', 'balayya': 55, 'sai RAM': 52, 'medium Bazzer': 58},
    {'Name': 'Red Chilli Powder', 'category': 'Oil & Spices', 'balayya': 65, 'sai RAM': 62, 'medium Bazzer': 68},
    {'Name': 'Coriander Powder', 'category': 'Oil & Spices', 'balayya': 60, 'sai RAM': 58, 'medium Bazzer': 63},
    {'Name': 'Salt', 'category': 'Oil & Spices', 'balayya': 22, 'sai RAM': 20, 'medium Bazzer': 24},
    {'Name': 'Tea', 'category': 'Snacks', 'balayya': 210, 'sai RAM': 205, 'medium Bazzer': 215},
    {'Name': 'Coffee', 'category': 'Snacks', 'balayya': 240, 'sai RAM': 235, 'medium Bazzer': 245},
    {'Name': 'Biscuits', 'category': 'Snacks', 'balayya': 40, 'sai RAM': 38, 'medium Bazzer': 42},
    {'Name': 'Chips', 'category': 'Snacks', 'balayya': 30, 'sai RAM': 28, 'medium Bazzer': 32},
    {'Name': 'Namkeen', 'category': 'Snacks', 'balayya': 45, 'sai RAM': 43, 'medium Bazzer': 47},
    {'Name': 'Soap', 'category': 'Personal Care', 'balayya': 45, 'sai RAM': 43, 'medium Bazzer': 48},
    {'Name': 'Shampoo', 'category': 'Personal Care', 'balayya': 180, 'sai RAM': 175, 'medium Bazzer': 188},
    {'Name': 'Toothpaste', 'category': 'Personal Care', 'balayya': 85, 'sai RAM': 82, 'medium Bazzer': 89},
    {'Name': 'Conditioner', 'category': 'Personal Care', 'balayya': 160, 'sai RAM': 155, 'medium Bazzer': 165},
    {'Name': 'Detergent Powder', 'category': 'Personal Care', 'balayya': 120, 'sai RAM': 116, 'medium Bazzer': 125},
    {'Name': 'Hand Wash', 'category': 'Personal Care', 'balayya': 70, 'sai RAM': 68, 'medium Bazzer': 72},
    {'Name': 'Bread', 'category': 'Grains', 'balayya': 36, 'sai RAM': 34, 'medium Bazzer': 38},
    {'Name': 'Pasta', 'category': 'Grains', 'balayya': 60, 'sai RAM': 58, 'medium Bazzer': 62},
    {'Name': 'Noodles', 'category': 'Grains', 'balayya': 48, 'sai RAM': 46, 'medium Bazzer': 50},
    {'Name': 'Cornflakes', 'category': 'Grains', 'balayya': 92, 'sai RAM': 89, 'medium Bazzer': 95},
    {'Name': 'Brown Rice', 'category': 'Grains', 'balayya': 74, 'sai RAM': 70, 'medium Bazzer': 76},
    {'Name': 'Black Gram', 'category': 'Dal', 'balayya': 118, 'sai RAM': 112, 'medium Bazzer': 122},
    {'Name': 'Green Gram', 'category': 'Dal', 'balayya': 108, 'sai RAM': 104, 'medium Bazzer': 110},
    {'Name': 'Masoor Dal', 'category': 'Dal', 'balayya': 105, 'sai RAM': 101, 'medium Bazzer': 107},
    {'Name': 'Peanut Butter', 'category': 'Dairy', 'balayya': 160, 'sai RAM': 155, 'medium Bazzer': 164},
    {'Name': 'Ghee', 'category': 'Dairy', 'balayya': 620, 'sai RAM': 610, 'medium Bazzer': 635},
    {'Name': 'Yogurt', 'category': 'Dairy', 'balayya': 44, 'sai RAM': 42, 'medium Bazzer': 46},
    {'Name': 'Cucumber', 'category': 'Vegetables', 'balayya': 24, 'sai RAM': 22, 'medium Bazzer': 26},
    {'Name': 'Spinach', 'category': 'Vegetables', 'balayya': 26, 'sai RAM': 24, 'medium Bazzer': 28},
    {'Name': 'Brinjal', 'category': 'Vegetables', 'balayya': 34, 'sai RAM': 32, 'medium Bazzer': 36},
    {'Name': 'Lady Finger', 'category': 'Vegetables', 'balayya': 38, 'sai RAM': 36, 'medium Bazzer': 40},
    {'Name': 'Capsicum', 'category': 'Vegetables', 'balayya': 42, 'sai RAM': 40, 'medium Bazzer': 44},
    {'Name': 'Ginger', 'category': 'Vegetables', 'balayya': 28, 'sai RAM': 26, 'medium Bazzer': 30},
    {'Name': 'Garlic', 'category': 'Vegetables', 'balayya': 25, 'sai RAM': 24, 'medium Bazzer': 27},
    {'Name': 'Lemon', 'category': 'Fruits', 'balayya': 30, 'sai RAM': 28, 'medium Bazzer': 32},
    {'Name': 'Papaya', 'category': 'Fruits', 'balayya': 60, 'sai RAM': 58, 'medium Bazzer': 62},
    {'Name': 'Guava', 'category': 'Fruits', 'balayya': 70, 'sai RAM': 68, 'medium Bazzer': 72},
    {'Name': 'Pomegranate', 'category': 'Fruits', 'balayya': 150, 'sai RAM': 146, 'medium Bazzer': 154},
    {'Name': 'Kiwi', 'category': 'Fruits', 'balayya': 110, 'sai RAM': 108, 'medium Bazzer': 112},
    {'Name': 'Avocado', 'category': 'Fruits', 'balayya': 180, 'sai RAM': 176, 'medium Bazzer': 184},
    {'Name': 'Coconut', 'category': 'Fruits', 'balayya': 50, 'sai RAM': 48, 'medium Bazzer': 52},
    {'Name': 'Groundnut Oil', 'category': 'Oil & Spices', 'balayya': 185, 'sai RAM': 180, 'medium Bazzer': 188},
    {'Name': 'Pepper', 'category': 'Oil & Spices', 'balayya': 90, 'sai RAM': 88, 'medium Bazzer': 92},
    {'Name': 'Cumin Seeds', 'category': 'Oil & Spices', 'balayya': 80, 'sai RAM': 78, 'medium Bazzer': 82},
    {'Name': 'Cardamom', 'category': 'Oil & Spices', 'balayya': 320, 'sai RAM': 315, 'medium Bazzer': 325},
    {'Name': 'Clove', 'category': 'Oil & Spices', 'balayya': 180, 'sai RAM': 176, 'medium Bazzer': 184},
    {'Name': 'Sambar Powder', 'category': 'Oil & Spices', 'balayya': 70, 'sai RAM': 68, 'medium Bazzer': 72},
    {'Name': 'Pickles', 'category': 'Snacks', 'balayya': 40, 'sai RAM': 38, 'medium Bazzer': 42},
    {'Name': 'Chocolate', 'category': 'Snacks', 'balayya': 80, 'sai RAM': 78, 'medium Bazzer': 82},
    {'Name': 'Soda', 'category': 'Snacks', 'balayya': 40, 'sai RAM': 38, 'medium Bazzer': 42},
    {'Name': 'Juice', 'category': 'Snacks', 'balayya': 95, 'sai RAM': 92, 'medium Bazzer': 98},
    {'Name': 'Mouthwash', 'category': 'Personal Care', 'balayya': 90, 'sai RAM': 88, 'medium Bazzer': 92},
    {'Name': 'Razors', 'category': 'Personal Care', 'balayya': 70, 'sai RAM': 68, 'medium Bazzer': 72},
    {'Name': 'Tissues', 'category': 'Personal Care', 'balayya': 35, 'sai RAM': 34, 'medium Bazzer': 36},
    {'Name': 'Sanitizer', 'category': 'Personal Care', 'balayya': 95, 'sai RAM': 92, 'medium Bazzer': 98},
  ];
}

List<Map<String, dynamic>> getGroceryItemsFromSnapshot(QuerySnapshot? snapshot) {
  if (snapshot != null && snapshot.docs.isNotEmpty) {
    return snapshot.docs
        .map((doc) => Map<String, dynamic>.from(doc.data() as Map<String, dynamic>))
        .toList();
  }
  return getDemoGroceries();
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Grocery Compare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) return const HomeScreen();
        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart, size: 100, color: Colors.white),
                const SizedBox(height: 24),
                const Text('Smart Grocery Compare',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Find best prices near you',
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
                const SizedBox(height: 60),
                isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton.icon(
                        onPressed: signInWithGoogle,
                        icon: const Icon(Icons.login, color: Colors.red),
                        label: const Text('Sign in with Google',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

List<Map<String, dynamic>> cartItems = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('🛒 Smart Grocery Compare'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: signOut),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, ${user?.displayName?.split(' ').first ?? 'User'}! 👋',
                      style: const TextStyle(fontSize: 18, color: Colors.white70)),
                  const SizedBox(height: 4),
                  const Text('Find Best Grocery Prices',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const CompareScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Search grocery items...', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const CompareScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(16)),
                        child: const Column(children: [
                          Icon(Icons.compare_arrows, color: Colors.white, size: 36),
                          SizedBox(height: 8),
                          Text('Compare\nPrices', textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const CartScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.orange.shade600, borderRadius: BorderRadius.circular(16)),
                        child: const Column(children: [
                          Icon(Icons.shopping_cart, color: Colors.white, size: 36),
                          SizedBox(height: 8),
                          Text('My\nCart', textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const MapScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(16)),
                        child: const Column(children: [
                          Icon(Icons.store, color: Colors.white, size: 36),
                          SizedBox(height: 8),
                          Text('Nearby\nStores', textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: ['All', 'Grains', 'Dal', 'Dairy', 'Vegetables', 'Fruits', 'Oil & Spices', 'Snacks', 'Personal Care']
                    .map((cat) => GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) => CompareScreen(category: cat == 'All' ? '' : cat))),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(cat, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text('Today\'s Best Deals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('75+ items', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('groceries').snapshots(),
              builder: (context, snapshot) {
                final items = getGroceryItemsFromSnapshot(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: items.take(8).map((data) {
                      final balayya = (data['balayya'] ?? 0) as int;
                      final saiRam = (data['sai RAM'] ?? 0) as int;
                      final mediumBazzer = (data['medium Bazzer'] ?? 0) as int;
                      final minPrice = [balayya, saiRam, mediumBazzer].reduce((a, b) => a < b ? a : b);
                      final minStore = balayya == minPrice ? 'Balayya' : saiRam == minPrice ? 'Sai RAM' : 'Medium Bazzer';
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 8)],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green.shade100,
                              child: const Icon(Icons.local_offer, color: Colors.green),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['Name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text('Best: Rs.$minPrice at $minStore', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class CompareScreen extends StatefulWidget {
  final String category;
  const CompareScreen({super.key, this.category = ''});
  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  String searchQuery = '';
  String selectedCategory = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Prices'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade50,
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (val) => setState(() => searchQuery = val.trim()),
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => searchQuery = '');
                        })
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: ['All', 'Grains', 'Dal', 'Dairy', 'Vegetables', 'Fruits', 'Oil & Spices', 'Snacks', 'Personal Care']
                  .map((cat) => GestureDetector(
                        onTap: () => setState(() => selectedCategory = cat == 'All' ? '' : cat),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedCategory == (cat == 'All' ? '' : cat)
                                ? Colors.green.shade700
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(cat,
                              style: TextStyle(
                                  color: selectedCategory == (cat == 'All' ? '' : cat)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('groceries').snapshots(),
              builder: (context, snapshot) {
                final items = getGroceryItemsFromSnapshot(snapshot.data).where((data) {
                  final name = (data['Name'] ?? '').toString().toLowerCase();
                  final matchSearch = searchQuery.isEmpty || name.contains(searchQuery.toLowerCase());
                  final matchCategory = selectedCategory.isEmpty || (data['category'] ?? '') == selectedCategory;
                  return matchSearch && matchCategory;
                }).toList();
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 60, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text('No items found for "$searchQuery"',
                            style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final data = items[index];
                    final balayya = (data['balayya'] ?? 0) as int;
                    final saiRam = (data['sai RAM'] ?? 0) as int;
                    final mediumBazzer = (data['medium Bazzer'] ?? 0) as int;
                    final prices = {'Balayya': balayya, 'Sai RAM': saiRam, 'Medium Bazzer': mediumBazzer};
                    final minPrice = prices.values.reduce((a, b) => a < b ? a : b);
                    final maxPrice = prices.values.reduce((a, b) => a > b ? a : b);
                    final savings = maxPrice - minPrice;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(data['Name'] ?? '',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
                                  child: Text('Save Rs.$savings',
                                      style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...prices.entries.map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(Icons.store,
                                            size: 16,
                                            color: e.value == minPrice ? Colors.green : Colors.grey),
                                        const SizedBox(width: 6),
                                        Text(e.key, style: const TextStyle(fontSize: 14)),
                                      ]),
                                      Row(children: [
                                        Text('Rs.${e.value}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: e.value == minPrice ? Colors.green : Colors.black87,
                                                fontWeight: e.value == minPrice
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                        if (e.value == minPrice)
                                          const Text('  ✓ Best',
                                              style: TextStyle(color: Colors.green, fontSize: 12)),
                                      ]),
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  cartItems.add(Map<String, dynamic>.from(data));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('${data['Name']} added to cart!'),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                                icon: const Icon(Icons.add_shopping_cart),
                                label: const Text('Add to Cart'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, int> storeTotals = {'Balayya': 0, 'Sai RAM': 0, 'Medium Bazzer': 0};
    for (var item in cartItems) {
      storeTotals['Balayya'] = storeTotals['Balayya']! + ((item['balayya'] ?? 0) as int);
      storeTotals['Sai RAM'] = storeTotals['Sai RAM']! + ((item['sai RAM'] ?? 0) as int);
      storeTotals['Medium Bazzer'] = storeTotals['Medium Bazzer']! + ((item['medium Bazzer'] ?? 0) as int);
    }
    final cheapest = cartItems.isEmpty ? 'Balayya' : storeTotals.entries.reduce((a, b) => a.value < b.value ? a : b).key;
    final mostExpensive = cartItems.isEmpty ? 'Balayya' : storeTotals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    final savings = storeTotals[mostExpensive]! - storeTotals[cheapest]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart (${cartItems.length} items)'),
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Your cart is empty!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Text('Add items from Compare Prices', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                if (savings > 0)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.green.shade50,
                    child: Row(
                      children: [
                        const Icon(Icons.savings, color: Colors.green, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('Save Rs.$savings by shopping at $cheapest!',
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(Icons.check, color: Colors.white)),
                          title: Text(item['Name'] ?? ''),
                          subtitle: Text('Best price: Rs.${[
                            (item['balayya'] ?? 0) as int,
                            (item['sai RAM'] ?? 0) as int,
                            (item['medium Bazzer'] ?? 0) as int
                          ].reduce((a, b) => a < b ? a : b)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() => cartItems.removeAt(index)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))],
                  ),
                  child: Column(
                    children: [
                      ...storeTotals.entries.map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: e.key == cheapest ? Colors.green.shade50 : Colors.grey.shade100,
                              border: Border.all(
                                  color: e.key == cheapest ? Colors.green : Colors.grey.shade300,
                                  width: e.key == cheapest ? 2 : 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.key,
                                    style: TextStyle(
                                        fontWeight: e.key == cheapest ? FontWeight.bold : FontWeight.normal)),
                                Text('Rs.${e.value}',
                                    style: TextStyle(
                                        color: e.key == cheapest ? Colors.green : Colors.black,
                                        fontWeight: FontWeight.bold)),
                                if (e.key == cheapest)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.green, borderRadius: BorderRadius.circular(12)),
                                    child: const Text('🏆 Best',
                                        style: TextStyle(color: Colors.white, fontSize: 12)),
                                  ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                      total: storeTotals[cheapest]!, storeName: cheapest))),
                          icon: const Icon(Icons.payment),
                          label: Text('Proceed to Pay Rs.${storeTotals[cheapest]}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final int total;
  final String storeName;
  const PaymentScreen({super.key, required this.total, required this.storeName});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = '';
  String selectedUPI = '';
  bool isProcessing = false;

  Future<void> processPayment() async {
    if (selectedPayment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method!'), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() => isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      cartItems.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OrderConfirmScreen()));
    }
  }

  Widget _upiOption(String name, IconData icon, Color color) {
    final isSelected = selectedPayment == 'UPI' && selectedUPI == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() { selectedPayment = 'UPI'; selectedUPI = name; }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade50 : Colors.white,
            border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300, width: isSelected ? 2 : 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.green : color, size: 28),
              const SizedBox(height: 4),
              Text(name, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentOption(String method, IconData icon, Color color) {
    final isSelected = selectedPayment == method;
    return GestureDetector(
      onTap: () => setState(() { selectedPayment = method; selectedUPI = ''; }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade50 : Colors.white,
          border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.green : color),
            const SizedBox(width: 12),
            Text(method, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 15)),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade400]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Total Amount', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text('Rs.${widget.total}',
                      style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  Text('at ${widget.storeName}', style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('UPI Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _upiOption('GPay', Icons.g_mobiledata, Colors.blue),
                const SizedBox(width: 8),
                _upiOption('PhonePe', Icons.phone_android, Colors.purple),
                const SizedBox(width: 8),
                _upiOption('Paytm', Icons.account_balance_wallet, Colors.blue.shade800),
                const SizedBox(width: 8),
                _upiOption('BHIM', Icons.account_balance, Colors.orange),
              ],
            ),
            const SizedBox(height: 16),
            if (selectedPayment == 'UPI') ...[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter UPI ID (example@upi)',
                  prefixIcon: const Icon(Icons.alternate_email, color: Colors.green),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
            ],
            const Text('Other Payment Methods', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _paymentOption('Credit Card', Icons.credit_card, Colors.blue),
            _paymentOption('Debit Card', Icons.credit_card_outlined, Colors.green),
            _paymentOption('Net Banking', Icons.language, Colors.orange),
            _paymentOption('Cash on Delivery', Icons.money, Colors.brown),
            if (selectedPayment == 'Credit Card' || selectedPayment == 'Debit Card') ...[
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 16,
                decoration: InputDecoration(
                  hintText: 'Card Number',
                  prefixIcon: const Icon(Icons.credit_card, color: Colors.green),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'MM/YY',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: 'CVV',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isProcessing ? null : processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Pay Rs.${widget.total}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text('100% Secure Payment', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              const Text('Order Placed! 🎉',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Order ID: $orderId', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              const Text('Your order has been placed successfully!',
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('🛵 Delivery in 30-45 minutes',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Back to Home', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _currentPosition;
  bool _isLoading = true;
  String _statusMessage = 'Getting your location...';
  final MapController _mapController = MapController();

  final List<Map<String, dynamic>> _nearbyStores = [
    {
      'name': 'Balayya Supermarket',
      'address': 'Poonamallee, Chennai',
      'lat': 13.0284,
      'lng': 79.9719,
      'color': Colors.green,
      'distance': '0.5 km',
      'rating': '4.2',
      'timing': '7AM - 10PM',
    },
    {
      'name': 'Sai RAM Stores',
      'address': 'Thandalam, Chennai',
      'lat': 13.0310,
      'lng': 79.9750,
      'color': Colors.orange,
      'distance': '1.2 km',
      'rating': '4.0',
      'timing': '8AM - 9PM',
    },
    {
      'name': 'Medium Bazzer',
      'address': 'Saveetha Nagar, Chennai',
      'lat': 13.0265,
      'lng': 79.9680,
      'color': Colors.blue,
      'distance': '2.1 km',
      'rating': '3.8',
      'timing': '6AM - 11PM',
    },
    {
      'name': 'Fresh Mart',
      'address': 'Poonamallee High Road',
      'lat': 13.0320,
      'lng': 79.9800,
      'color': Colors.purple,
      'distance': '1.8 km',
      'rating': '4.5',
      'timing': '7AM - 10PM',
    },
    {
      'name': 'Daily Needs Store',
      'address': 'Thandalam Main Road',
      'lat': 13.0240,
      'lng': 79.9650,
      'color': Colors.red,
      'distance': '2.5 km',
      'rating': '3.9',
      'timing': '8AM - 10PM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _statusMessage = 'Location services disabled. Showing Saveetha area map.';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _statusMessage = 'Location permission denied. Showing Saveetha area map.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _statusMessage = 'Location permission permanently denied.';
          _isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _isLoading = false;
        _statusMessage = 'Your location found!';
      });

      _mapController.move(
          LatLng(position.latitude, position.longitude), 14.0);
    } catch (e) {
      setState(() {
        _statusMessage = 'Could not get location. Showing Saveetha area map.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultCenter = LatLng(13.0284, 79.9719);
    final mapCenter = _currentPosition != null
        ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
        : defaultCenter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Stores'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
            tooltip: 'Get My Location',
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: mapCenter,
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.smartgrocery2',
                      ),
                      MarkerLayer(
                        markers: [
                          if (_currentPosition != null)
                            Marker(
                              point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.person_pin_circle,
                                  color: Colors.blue, size: 40),
                            ),
                          ..._nearbyStores.map((store) => Marker(
                                point: LatLng(store['lat'] as double, store['lng'] as double),
                                width: 40,
                                height: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(store['name'],
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 8),
                                            Row(children: [
                                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text(store['address'], style: const TextStyle(color: Colors.grey)),
                                            ]),
                                            const SizedBox(height: 4),
                                            Row(children: [
                                              const Icon(Icons.star, size: 16, color: Colors.amber),
                                              const SizedBox(width: 4),
                                              Text('${store['rating']} rating'),
                                              const SizedBox(width: 16),
                                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text(store['timing']),
                                            ]),
                                            const SizedBox(height: 4),
                                            Row(children: [
                                              const Icon(Icons.directions_walk, size: 16, color: Colors.green),
                                              const SizedBox(width: 4),
                                              Text(store['distance'],
                                                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.store_mall_directory,
                                      color: store['color'] as Color, size: 36),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Icon(
                  _currentPosition != null ? Icons.location_on : Icons.location_off,
                  size: 16,
                  color: _currentPosition != null ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 6),
                Text(_statusMessage,
                    style: TextStyle(
                        fontSize: 12,
                        color: _currentPosition != null ? Colors.green : Colors.orange)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _nearbyStores.length,
              itemBuilder: (context, index) {
                final store = _nearbyStores[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    onTap: () {
                      _mapController.move(
                          LatLng(store['lat'] as double, store['lng'] as double), 15.0);
                    },
                    leading: CircleAvatar(
                      backgroundColor: store['color'] as Color,
                      child: const Icon(Icons.store, color: Colors.white),
                    ),
                    title: Text(store['name'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(store['address'] as String),
                        Row(children: [
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          Text(' ${store['rating']}  •  ${store['timing']}',
                              style: const TextStyle(fontSize: 11)),
                        ]),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(store['distance'] as String,
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
