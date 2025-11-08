import 'package:chats_app/features/home/presentation/views/all_chats_view.dart';
import 'package:chats_app/features/profile/presentation/view/profile_view.dart';
import 'package:chats_app/features/search_users/presentation/views/users_view.dart';
import 'package:flutter/material.dart';

class NormalBottom extends StatefulWidget {
  @override
  _NormalBottomState createState() => _NormalBottomState();
}

class _NormalBottomState extends State<NormalBottom> {
  int _currentIndex = 0;

  final List<Widget> _options = <Widget>[
    const AllChatsView(),
    const UsersView(),
    const ProfileView()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _options[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedFontSize: 0, 
        unselectedFontSize: 0,
        onTap: changeIndex,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: AnimatedScale(
                scale: _currentIndex == 0 ? 1.5 : 1, 
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  _currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                  size: 28, 
                  color: _currentIndex == 0 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: AnimatedScale(
                scale: _currentIndex == 1 ? 1.5 : 1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  _currentIndex == 1
                      ? Icons.add_circle
                      : Icons.add_circle_outline,
                  size: 30,
                  color: _currentIndex == 1 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 6), 
              child: AnimatedScale(
                scale: _currentIndex == 2 ? 1.5 : 1, 
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  _currentIndex == 2 ? Icons.person : Icons.person_2_outlined,

                  size: 28, 
                  color: _currentIndex == 2 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  void changeIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
