import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(IbnAyallTVApp());
}

class IbnAyallTVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ابن عيال🤡',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ChannelHomePage(),
    );
  }
}

class ChannelHomePage extends StatefulWidget {
  @override
  _ChannelHomePageState createState() => _ChannelHomePageState();
}

class _ChannelHomePageState extends State<ChannelHomePage> {
  final nameController = TextEditingController();
  final freqController = TextEditingController();
  final urlController = TextEditingController();

  List<Map<String, String>> channels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ابن عيال🤡 - تلفزيون مباشر'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'اسم القناة'),
            ),
            TextField(
              controller: freqController,
              decoration: InputDecoration(labelText: 'تردد القناة (اختياري)'),
            ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'رابط البث المباشر (m3u8 أو mp4)'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && urlController.text.isNotEmpty) {
                  setState(() {
                    channels.add({
                      'name': nameController.text,
                      'frequency': freqController.text,
                      'url': urlController.text,
                    });
                    nameController.clear();
                    freqController.clear();
                    urlController.clear();
                  });
                }
              },
              child: Text('إضافة القناة'),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: channels.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(channels[index]['name'] ?? ''),
                    subtitle: Text('التردد: ${channels[index]['frequency'] ?? 'غير محدد'}'),
                    trailing: Icon(Icons.play_circle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerPage(url: channels[index]['url']!),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String url;

  VideoPlayerPage({required this.url});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
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
      appBar: AppBar(title: Text('تشغيل القناة')),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
