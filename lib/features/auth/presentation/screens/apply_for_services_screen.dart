import 'package:flutter/material.dart';
import 'colors.dart';

class ApplyForServicesScreen extends StatelessWidget {
  const ApplyForServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Services'),
        backgroundColor: kPrimaryTeal,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit_note_outlined, size: 64, color: kPrimaryTeal),
              SizedBox(height: 16),
              Text(
                'Apply for Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Start a new application or continue a saved application here.',
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