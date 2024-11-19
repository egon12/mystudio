import 'package:flutter/material.dart';
import 'package:mystudio/components/navbar.dart';
import 'package:video_player/video_player.dart';

class VideoEditingScreen extends StatefulWidget {
  const VideoEditingScreen({super.key});

  @override
  _VideoEditingScreenState createState() => _VideoEditingScreenState();
}

class _VideoEditingScreenState extends State<VideoEditingScreen> {
  VideoPlayerController _controller = VideoPlayerController.networkUrl(
    Uri.parse('https://cdn.pixabay.com/video/2024/09/07/230248_large.mp4'),
  );

  final TextEditingController _textController = TextEditingController(
      text: 'https://cdn.pixabay.com/video/2024/09/07/230247_large.mp4');

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      setState(() {});
    });

    _textController.addListener(() {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(_textController.text),
      )..initialize().then((_) => setState(() {}));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Editing App'),
      ),
      bottomNavigationBar: NavBar(
        activeScreen: widget,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _textController,
            ),
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            VideoProgressIndicator(_controller, allowScrubbing: true),
            Row(
              children: [
                IconButton(
                  icon: Icon(_controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    setState(() {
                      _controller.seekTo(Duration.zero);
                      _controller.pause();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
