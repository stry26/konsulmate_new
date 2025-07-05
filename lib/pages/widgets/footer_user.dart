// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import '../user/homepage_user.dart';
import '../user/listchat_user.dart';
import '../user/history_user.dart';

class FooterUser extends StatelessWidget {
  final int currentIndex;
  final String userName;
  final String userId;
  final String asalKampus;

  const FooterUser({
    super.key,
    required this.currentIndex,
    required this.userName,
    required this.userId,
    this.asalKampus = "",
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget page;
    switch (index) {
      case 0:
        page = HomeUser(userName: userName, userId: userId);
        break;
      case 1:
        page = ListChatUser(userName: userName, userId: userId);
        break;
      case 3:
        page = HistoryUser(userName: userName, userId: userId);
        break;
      default:
        page = HomeUser(userName: userName, userId: userId);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFF80C9FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 0, Icons.home_outlined),
          _buildNavItem(
            context,
            1,
            Icons.chat_bubble_outline,
            iconSize: 22,
          ), // icon chat lebih kecil
          _buildNavItem(context, 3, Icons.history),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon, {
    double iconSize = 28,
    double boxSize = 48,
  }) {
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => _onItemTapped(context, index),
      child: SizedBox(
        width: boxSize,
        height: boxSize,
        child:
            isSelected
                ? Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: Colors.white, size: iconSize),
                )
                : Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}