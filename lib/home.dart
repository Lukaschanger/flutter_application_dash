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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  StatCard(
                    title: 'Number of Students',
                    value: '12000',
                    change: '5% higher vs last week',
                    icon: Icons.people,
                    color: Colors.redAccent,
                  ),
                  SizedBox(height: 12),
                  StatCard(
                    title: 'Penetration App',
                    value: '16',
                    change: '2 assignments left',
                    icon: Icons.assignment,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 12),
                  StatCard(
                    title: 'App Users',
                    value: '250\$',
                    change: 'No more fees this semester',
                    icon: Icons.account_balance_wallet,
                    color: Colors.amber,
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
