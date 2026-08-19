import 'package:flutter/material.dart';
import 'colors.dart';

class ComplaintsQueriesScreen extends StatelessWidget {
  const ComplaintsQueriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints & Queries'),
        backgroundColor: kPrimaryTeal,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.gavel_outlined, size: 64, color: kPrimaryTeal),
              SizedBox(height: 16),
              Text(
                'Complaints & Queries',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'File a complaint or track the status of an existing query here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}