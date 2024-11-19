import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mystudio/components/navbar.dart';

class MusicCreatorScreen extends StatefulWidget {
  const MusicCreatorScreen({super.key});

  @override
  _MusicCreatorScreenState createState() => _MusicCreatorScreenState();
}

class _MusicCreatorScreenState extends State<MusicCreatorScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound(String soundFile) {
    _audioPlayer.play(AssetSource(soundFile));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Creator App'),
      ),
      bottomNavigationBar: NavBar(activeScreen: widget),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildSoundButton('kick', 'sounds/kick.mp3'),
          _buildSoundButton('snare', 'sounds/snare.mp3'),
          _buildSoundButton('open hh', 'sounds/open_hihat.mp3'),
          _buildSoundButton('crash', 'sounds/cymbals.mp3'),
        ],
      ),
    );
  }

  Widget _buildSoundButton(String label, String soundFile) {
    return ElevatedButton(
      onPressed: () => _playSound(soundFile),
      child: Text(label),
    );
  }
}
