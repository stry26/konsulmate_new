// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../mentor/profilepage_mentor.dart'; 

class AppBarMentor extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? bidangKeahlian; 
  final String? userId;

  const AppBarMentor({
    super.key,
    required this.userName,
    this.bidangKeahlian,
    this.userId,
  });

  @override
  Size get preferredSize => const Size.fromHeight(180);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getBidangKeahlian(),
      builder: (context, snapshot) {
        String keahlian = snapshot.data ?? bidangKeahlian ?? 'Mentor';
        return _buildAppBar(context, keahlian);
      },
    );
  }

  Future<String> _getBidangKeahlian() async {
    if (userId == null) return bidangKeahlian ?? '';

    try {
      final doc = await FirebaseFirestore.instance.collection('mentors').doc(userId).get();
      if (doc.exists) {
        return doc['keahlian'] ?? bidangKeahlian ?? '';
      }
    } catch (e) {
      debugPrint('Error getting mentor data: $e');
    }
    return bidangKeahlian ?? '';
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String keahlian) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF80C9FF), // Biru di atas
              Colors.white,      // Putih di bawah
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Name and expertise (di kiri)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hello, $userName',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        keahlian,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Profile button (di kanan)
                GestureDetector(
                  onTap: () {
                    if (userId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileMentor(
                            userName: userName,
                            userId: userId!,
                            bidangKeahlian: keahlian,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF80C9FF),
                    ),
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