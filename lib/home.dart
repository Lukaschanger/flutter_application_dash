import 'package:flutter/material.dart';
import 'package:flutter_application_dash/statcard.dart';
import 'package:flutter_application_dash/vertical_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          VerticalNavbar(), // Integrated as part of the main layout
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 2, // Two cards per row
                crossAxisSpacing: 12, // Horizontal space between cards
                mainAxisSpacing: 12, // Vertical space between cards
                childAspectRatio: (3 /
                    1), // Adjust this value to control card size, e.g., 3/1 makes each card three times as wide as its height
                children: const [
                  StatCard(
                    title: 'Number of Students',
                    value: '12000',
                    change: '5% higher vs last week',
                    icon: Icons.people,
                    color: Colors.redAccent,
                  ),
                  StatCard(
                    title: 'Penetration App',
                    value: '16',
                    change: '2 assignments left',
                    icon: Icons.assignment,
                    color: Colors.blueAccent,
                  ),
                  StatCard(
                    title: 'App Users',
                    value: '250\$',
                    change: 'No more fees this semester',
                    icon: Icons.account_balance_wallet,
                    color: Colors.amber,
                  ),
                  StatCard(
                    title: 'Random Data',
                    value: '42',
                    change: 'Random fluctuation',
                    icon: Icons.shuffle,
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
