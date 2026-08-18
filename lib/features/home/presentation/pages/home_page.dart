import 'package:flutter/material.dart';

// --- Color Constants ---
const Color kPrimaryTeal = Color(0xFF006B70);
const Color kLightTeal = Color(0xFFE2F4F4);
const Color kScaffoldBg = Color(0xFFF7F9FA);

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
  final Widget destination;

  ServiceItem({
    required this.title,
    required this.icon,
    required this.destination,
  });
}

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of Services with target destination pages
    final List<ServiceItem> services = [
      ServiceItem(
        title: 'Citizen Support',
        icon: Icons.people_alt_outlined,
        destination: const DetailScreen(title: 'Citizen Support'),
      ),
      ServiceItem(
        title: 'Educational\nServices',
        icon: Icons.menu_book_outlined,
        destination: const DetailScreen(title: 'Educational Services'),
      ),
      ServiceItem(
        title: 'Apply for\nServices',
        icon: Icons.edit_note_outlined,
        destination: const DetailScreen(title: 'Apply for Services'),
      ),
      ServiceItem(
        title: 'Legal Portal',
        icon: Icons.balance_outlined,
        destination: const DetailScreen(title: 'Legal Portal'),
      ),
      ServiceItem(
        title: 'Training Modules',
        icon: Icons.school_outlined,
        destination: const DetailScreen(title: 'Training Modules'),
      ),
      ServiceItem(
        title: 'Complaints &\nQueries',
        icon: Icons.gavel_outlined,
        destination: const DetailScreen(title: 'Complaints & Queries'),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Header
              _buildProfileHeader(),
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

              // 6. Carousel Indicator Dots
              _buildPageIndicator(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Sub-Widgets ---

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFF3D063),
          child: CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'ID: 123456789',
                style: TextStyle(fontSize: 13, color: Colors.black54),
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
            builder: (context) => const DetailScreen(title: 'Service Status Details'),
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
                    MaterialPageRoute(builder: (context) => item.destination),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    // Circular Icon Button
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
                    // Title
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

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: kPrimaryTeal,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 20,
          height: 7,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

// --- Generic Detail Page for Demonstration ---
class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: kPrimaryTeal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}