import 'package:flutter/material.dart';
import 'package:mystudio/screen/drawing_screen.dart';
import 'package:mystudio/screen/music_creator_screen.dart';
import 'package:mystudio/screen/video_editing_screen.dart';

class NavBar extends StatelessWidget {
  @override
  final Widget? activeScreen;

  const NavBar({super.key, this.activeScreen});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTap(context),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: "video"),
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "music"),
        BottomNavigationBarItem(icon: Icon(Icons.draw), label: "draw"),
      ],
      selectedItemColor: Colors.purple,
    );
  }

  ValueChanged<int> onTap(BuildContext context) {
    return (index) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              switch (index) {
                case 0:
                  return const VideoEditingScreen();
                case 1:
                  return const MusicCreatorScreen();
                case 2:
                  return const DrawingScreen();
                default:
                  throw Exception("not found index");
              }
            },
          ),
        );
  }

  int get _currentIndex {
    if (activeScreen is MusicCreatorScreen) {
      return 1;
    } else if (activeScreen is VideoEditingScreen) {
      return 0;
    } else if (activeScreen is DrawingScreen) {
      return 2;
    } else {
      return 0;
    }
  }
}
