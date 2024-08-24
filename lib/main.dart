import 'package:flutter/material.dart';
import 'package:app/pages/live.dart';
import 'package:app/pages/moderators.dart';
import 'package:app/pages/my_song.dart';

void main() {
  runApp(const AppFrame());
}

class AppFrame extends StatefulWidget {
  const AppFrame({super.key});

  @override
  State<AppFrame> createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
  final List<Widget> _pages = <Widget>[
    const LivePage(),
    const SongPage(),
    const ModeratorsPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text('Radio App'),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: 'Songwunsch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Moderatoren',
            ),
          ],
        ),
      ),
    );
  }
}
