import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Required for context.read<AuthCubit>()
import 'package:authenapp/features/auth/presentation/cubits/auth_cubit.dart'; // Adjust path if needed
import 'package:authenapp/features/auth/presentation/screens/colors.dart';
import 'package:authenapp/features/auth/presentation/screens/citizen_support_screen.dart';
import 'package:authenapp/features/auth/presentation/screens/educational_services_screen.dart';
import 'package:authenapp/features/auth/presentation/screens/apply_for_services_screen.dart';
import 'package:authenapp/features/auth/presentation/screens/legal_portal_screen.dart';
import 'package:authenapp/features/auth/presentation/screens/training_modules_screen.dart';
import 'package:authenapp/features/auth/presentation/screens/complaints_queries_screen.dart';
import 'package:authenapp/features/auth/presentation/screens/service_status_screen.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBg,
        fontFamily: 'Roboto',
      ),
      home: const ServiceHomeScreen(),
    );
  }
}

// --- Service Item Model ---
class ServiceItem {
  final String title;
  final IconData icon;
  final WidgetBuilder builder;

  ServiceItem({
    required this.title,
    required this.icon,
    required this.builder,
  });
}

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServiceItem> services = [
      ServiceItem(
        title: 'Citizen Support',
        icon: Icons.people_alt_outlined,
        builder: (context) => const CitizenSupportScreen(),
      ),
      ServiceItem(
        title: 'Educational\nServices',
        icon: Icons.menu_book_outlined,
        builder: (context) => const EducationalServicesScreen(),
      ),
      ServiceItem(
        title: 'Apply for\nServices',
        icon: Icons.edit_note_outlined,
        builder: (context) => const ApplyForServicesScreen(),
      ),
      ServiceItem(
        title: 'Legal Portal',
        icon: Icons.balance_outlined,
        builder: (context) => const LegalPortalScreen(),
      ),
      ServiceItem(
        title: 'Training Modules',
        icon: Icons.school_outlined,
        builder: (context) => const TrainingModulesScreen(),
      ),
      ServiceItem(
        title: 'Complaints &\nQueries',
        icon: Icons.gavel_outlined,
        builder: (context) => const ComplaintsQueriesScreen(),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Header (context passed)
              _buildProfileHeader(context),
              const SizedBox(height: 16),

              // 2. Search Bar
              _buildSearchBar(),
              const SizedBox(height: 16),

              // 3. Service Status Card
              _buildServiceStatusCard(context),
              const SizedBox(height: 20),

              // 4. Popular Services Grid Card
              _buildServicesCard(context, services),
              const SizedBox(height: 20),

              // 5. Bottom Banner
              _buildBottomBanner(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // --- Sub-Widgets ---

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage("lib/assets/user.jpg"),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yash Mehta',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined, size: 26),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_outlined, size: 24),
        ),
        // Logout Button
        IconButton(
          onPressed: () {
            final authCubit = context.read<AuthCubit>();
            authCubit.logout();
          },
          icon: const Icon(Icons.logout, size: 24, color: Colors.redAccent),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildServiceStatusCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ServiceStatusScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kPrimaryTeal,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Color(0xFF64B5F6), width: 3),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application ID: ACS-2023-7845',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Registration Date: 2 July 2023',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesCard(BuildContext context, List<ServiceItem> services) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 18,
              crossAxisSpacing: 10,
              childAspectRatio: 0.76,
            ),
            itemBuilder: (context, index) {
              final item = services[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: item.builder),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: kLightTeal,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: kPrimaryTeal, size: 30),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBanner() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: kPrimaryTeal,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A DIGITAL\nJUSTICE JOURNEY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'START NOW',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.groups_outlined, size: 55, color: Colors.white70),
        ],
      ),
    );
  }
}