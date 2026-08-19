import 'package:flutter/material.dart';
import 'colors.dart';

class LegalPortalScreen extends StatelessWidget {
  const LegalPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Portal'),
        backgroundColor: kPrimaryTeal,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.balance_outlined, size: 64, color: kPrimaryTeal),
              SizedBox(height: 16),
              Text(
                'Legal Portal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Access legal documents, case status, and legal aid resources here.',
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